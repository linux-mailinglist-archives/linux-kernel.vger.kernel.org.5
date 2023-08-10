Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF13877777A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjHJLtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjHJLtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:49:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8C1583;
        Thu, 10 Aug 2023 04:49:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C26B8D75;
        Thu, 10 Aug 2023 04:50:22 -0700 (PDT)
Received: from [10.163.55.44] (unknown [10.163.55.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E71C63F64C;
        Thu, 10 Aug 2023 04:49:35 -0700 (PDT)
Message-ID: <8a92c349-8c72-db98-3fff-9a7d8a6b04fb@arm.com>
Date:   Thu, 10 Aug 2023 17:19:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V13 - RESEND 01/10] drivers: perf: arm_pmu: Add new
 sched_task() callback
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
 <20230711082455.215983-2-anshuman.khandual@arm.com>
 <0ed54ef6-e502-7c33-6e3f-08de76786245@arm.com>
 <20230810094146.GB5365@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230810094146.GB5365@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/23 15:11, Will Deacon wrote:
> On Thu, Aug 10, 2023 at 10:35:42AM +0530, Anshuman Khandual wrote:
>> I am just wondering - would it be possible for you to take this pre-requisite
>> patch stand alone for the upcoming merge window. This has been acked by Mark
>> earlier. Besides, I am also working on your other suggestions on the series,
>> and will respond soon. Thank you.
> 
> I can if it helps in some way, but I'm not seeing how it does. Can't you
> just carry this along with the BRBE changes that use it? How does it benefit
> anybody on its own?
It might help de-clutter our conversation and focus on BRBE specific
implementation stuff next time around in V14. Also this change here
is quite harmless for any other thing, hence without much risk.
