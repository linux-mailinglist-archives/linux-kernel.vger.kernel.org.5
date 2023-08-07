Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39049772361
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjHGMEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjHGMEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:04:10 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB6718E;
        Mon,  7 Aug 2023 05:03:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VpGaULx_1691409755;
Received: from 30.221.158.57(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VpGaULx_1691409755)
          by smtp.aliyun-inc.com;
          Mon, 07 Aug 2023 20:02:36 +0800
Message-ID: <110412ae-108a-27ed-b0f7-8f30eab122a2@linux.alibaba.com>
Date:   Mon, 7 Aug 2023 20:02:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v6 4/7] perf test: Fix matching_pmu
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1691394685-61240-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1691394685-61240-5-git-send-email-renyu.zj@linux.alibaba.com>
 <c791e9b5-e459-539b-d9f7-8808486a1aa8@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <c791e9b5-e459-539b-d9f7-8808486a1aa8@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/7 下午5:21, John Garry 写道:
> On 07/08/2023 08:51, Jing Zhang wrote:
>> The perf_pmu_test_event.matching_pmu didn't work. No matter what its
>> value is, it does not affect the test results. So let matching_pmu be
>> used for matching perf_pmu_test_pmu.pmu.name.
>>
>> Fixes: 5a65c0c8f6fd ("perf test: Re-add pmu-event uncore PMU alias test")
> 
> Is this tag correct, as I was not sure if this ever worked?
> 

I added the tag with reference to the previous fixed patch, and it seems correct.

> BTW, I am not sure how useful fixes tags are for self-test anyway...
> 

I'm not sure if it's useful either, but I added it anyway.:)

>> Signed-off-by: Jing Zhang<renyu.zj@linux.alibaba.com>
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Thank you sincerely!
