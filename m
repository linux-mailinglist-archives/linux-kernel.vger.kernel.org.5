Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18758766EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbjG1ODD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbjG1ODB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:03:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AB9A3A92;
        Fri, 28 Jul 2023 07:03:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11E162F4;
        Fri, 28 Jul 2023 07:03:43 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.89.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C143C3F67D;
        Fri, 28 Jul 2023 07:02:56 -0700 (PDT)
Date:   Fri, 28 Jul 2023 15:02:54 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        anshuman.khandual@arm.com, will@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE
 capability
Message-ID: <ZMPKjl5mDsiRVQ_C@FVFF77S0Q05N>
References: <20230724134500.970496-1-james.clark@arm.com>
 <20230725121023.GH3765278@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725121023.GH3765278@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 02:10:23PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 24, 2023 at 02:44:55PM +0100, James Clark wrote:
> 
> > James Clark (4):
> >   arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability
> >   perf/x86: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
> >   arm_pmu: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
> >   perf: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
> > 
> >  arch/x86/events/core.c     |  1 -
> >  drivers/perf/arm_pmu.c     | 10 ++++++----
> >  include/linux/perf_event.h |  7 +++----
> >  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> Thanks!

Ah, I see that you've queued that in your perf/core branch in your queue tree.

Given that, I assume you don't need anything from me or from Will, but just in
case, for the series:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
