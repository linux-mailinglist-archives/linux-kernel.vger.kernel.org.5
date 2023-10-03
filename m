Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083B27B632E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239247AbjJCIGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjJCIGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:06:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE524A3;
        Tue,  3 Oct 2023 01:06:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF203C15;
        Tue,  3 Oct 2023 01:06:39 -0700 (PDT)
Received: from [10.57.93.198] (unknown [10.57.93.198])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CC043F5A1;
        Tue,  3 Oct 2023 01:05:59 -0700 (PDT)
Message-ID: <4cf233b1-57e0-f1f0-4def-1cbb7bf46e9f@arm.com>
Date:   Tue, 3 Oct 2023 09:06:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 00/18] Introduce runtime modifiable Energy Model
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        wvw@google.com
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
 <20230928215628.u53wmwlr6lm5qzpe@airbuntu>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230928215628.u53wmwlr6lm5qzpe@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,


On 9/28/23 22:56, Qais Yousef wrote:
> Hi Lukasz
> 
> On 09/25/23 09:11, Lukasz Luba wrote:
>> Hi all,
>>
>> This patch set adds a new feature which allows to modify Energy Model (EM)
>> power values at runtime. It will allow to better reflect power model of
>> a recent SoCs and silicon. Different characteristics of the power usage
>> can be leveraged and thus better decisions made during task placement in EAS.
>>
>> It's part of feature set know as Dynamic Energy Model. It has been presented
>> and discussed recently at OSPM2023 [3]. This patch set implements the 1st
>> improvement for the EM.
> 
> Thanks for the series! I'm on CC this time :-) Unfortunately I have a planned
> holiday starting tomorrow, so won't get a chance to do proper review till I'm
> back which would be few weeks from now.
> 
> I just want to iterate that this is a real problem being seen in practice where
> it's hard to provide a single average EM for all workloads now. So we certainly
> need something like this.
> 
> Hopefully I'll get a chance to help with review when I'm back from holidays.
> 
> 

Thanks and no worries, there will be v5. I am going to address comments
from Rafael. So probably when you're back the v5 would be there then.

Regards,
Lukasz
