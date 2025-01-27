package com.project.myserver.restapi.repository

import com.project.myserver.restapi.entity.Budget
import org.springframework.data.jpa.repository.JpaRepository

interface BudgetRepository : JpaRepository<Budget, Long> {
}