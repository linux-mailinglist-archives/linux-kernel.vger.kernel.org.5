Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BDF751936
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjGMHAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjGMHAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:00:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D00119;
        Wed, 12 Jul 2023 23:59:59 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R1llB1GGXzNm6J;
        Thu, 13 Jul 2023 14:56:38 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 14:59:54 +0800
Subject: Re: [PATCH 4/5] perf test: Add test case for record tracking
To:     Ian Rogers <irogers@google.com>, <adrian.hunter@intel.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <kan.liang@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
References: <20230704074217.240939-1-yangjihong1@huawei.com>
 <20230704074217.240939-5-yangjihong1@huawei.com>
 <CAP-5=fVv5C75xy-kMRfssCGd6syx5H1FKe1xs2K_+xQhQVJQPA@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <fd039d2b-9be8-75b0-56ba-081755bd4f0e@huawei.com>
Date:   Thu, 13 Jul 2023 14:59:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fVv5C75xy-kMRfssCGd6syx5H1FKe1xs2K_+xQhQVJQPA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/7/13 4:48, Ian Rogers wrote:
> On Tue, Jul 4, 2023 at 12:44 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> Add a new test case to record tracking side-band events for all CPUs when
>> tracing selected CPUs
> 
> We're using "tracking" and "sideband" as synonyms, I think it would be
> clearer to just use "sideband" and not use "tracking". I see both
> terms in tools/perf/Documentation/perf-intel-pt.txt
> 
Okay, will use "sideband events" instead of "tracking events" in the 
next version.

Thanks,
Yang
