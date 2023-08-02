Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C389076C95E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjHBJVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjHBJVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:21:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3661A8;
        Wed,  2 Aug 2023 02:21:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2036113E;
        Wed,  2 Aug 2023 02:22:27 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4BD33F5A1;
        Wed,  2 Aug 2023 02:21:41 -0700 (PDT)
Message-ID: <fc0098cc-5217-a357-5c91-26a77f164eab@arm.com>
Date:   Wed, 2 Aug 2023 10:21:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 4/5] perf vendor events arm64: Update N2-r0p3 and V2
 metrics and events using Arm telemetry repo
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, renyu.zj@linux.alibaba.com,
        john.g.garry@oracle.com, namhyung@kernel.org,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230711100218.1651995-1-james.clark@arm.com>
 <20230711100218.1651995-5-james.clark@arm.com>
 <CAP-5=fVPriUQZN+OzDOVnMMe0y9QzRHuaBMgrCcSvbE+3ME=Lg@mail.gmail.com>
 <59630da4-316b-55c4-c2c7-30c53b1ba642@arm.com>
 <750344ea-d1a2-87c2-b790-38dd79e11223@arm.com>
 <CAP-5=fU1z2+ZUFP0BdQyvy0DK_am9p=9p3goeB44M2cLiF7y7g@mail.gmail.com>
 <ZMlM2rTqggT+0iGJ@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <ZMlM2rTqggT+0iGJ@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/08/2023 19:20, Arnaldo Carvalho de Melo wrote:
> Em Tue, Aug 01, 2023 at 08:56:35AM -0700, Ian Rogers escreveu:
>> On Tue, Aug 1, 2023 at 3:55 AM James Clark <james.clark@arm.com> wrote:
>>> On 12/07/2023 09:33, James Clark wrote:
>>>> On 12/07/2023 02:04, Ian Rogers wrote:
>>>>> It might be nice to add "beat" to the glossary:
>>>>> https://perf.wiki.kernel.org/index.php/Glossary
> 
>>>> I requested an account and I will add it. There is a definition in the
>>>> Arm glossary here if, like me, you weren't sure:
> 
>>> I'm not sure if my wiki account request worked. I didn't get a response,
>>> and I also get a "your IP is blocked from editing" on the password reset
>>> page (this is an Arm internal IP).
>>> Do you know anything about the account request procedure?
> 
>> The wiki is run by RedHat and Arnaldo is able to give permissions.
>> Arnaldo could you take a look?
> 
> Lemme check.
> 
> - Arnaldo

Thanks, got it and added the definition successfully

James
