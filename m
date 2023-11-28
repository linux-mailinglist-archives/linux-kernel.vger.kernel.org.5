Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E291D7FB145
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbjK1Fcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjK1Fch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:32:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61861E1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:32:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBE32C15;
        Mon, 27 Nov 2023 21:33:31 -0800 (PST)
Received: from [10.163.33.60] (unknown [10.163.33.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DECF3F5A1;
        Mon, 27 Nov 2023 21:32:42 -0800 (PST)
Message-ID: <be9bb045-14f8-42ce-87b3-8794b03801d5@arm.com>
Date:   Tue, 28 Nov 2023 11:02:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RESEND] drivers: perf: arm_pmuv3: Add new macro
 PMUV3_INIT_MAP_EVENT()
Content-Language: en-US
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>
References: <20231114061656.337231-1-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20231114061656.337231-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/23 11:46, Anshuman Khandual wrote:
> This further compacts all remaining PMU init procedures requiring specific
> map_event functions via a new macro PMUV3_INIT_MAP_EVENT(). While here, it
> also changes generated init function names to match to those generated via
> the other macro PMUV3_INIT_SIMPLE(). This does not cause functional change.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.7-rc1
> 
> Changes in V2:
> 
> https://lore.kernel.org/all/20231020051543.2818951-1-anshuman.khandual@arm.com/
> 
> - Updated the commit message
> - Rebased the patch after the following change
>   https://lore.kernel.org/all/20231016025436.1368945-1-anshuman.khandual@arm.com/

Hello Will/Mark,

Any updates or concerns on this patch ?

- Anshuman
