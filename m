Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729F67E3645
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjKGIF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjKGIFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:05:18 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB12DEA;
        Tue,  7 Nov 2023 00:05:14 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D3C5F8155;
        Tue,  7 Nov 2023 16:05:12 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Nov
 2023 16:05:12 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Nov
 2023 16:05:12 +0800
Message-ID: <a2dbb182-2573-4c86-7e18-319d26a6593c@starfivetech.com>
Date:   Tue, 7 Nov 2023 16:05:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v11 0/9] Add StarFive Camera Subsystem driver
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <changhuang.liang@starfivetech.com>
References: <20231025031422.3695-1-jack.zhu@starfivetech.com>
 <15ef0a70-734e-280a-f014-41914a55d8cf@starfivetech.com>
 <a3a2c179-2cbe-5a55-a21e-b45abfb6d494@starfivetech.com>
 <2023110745-tableful-trapezoid-4206@gregkh>
 <2023110730-thousand-skyrocket-d6ba@gregkh>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <2023110730-thousand-skyrocket-d6ba@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/7 14:16, Greg Kroah-Hartman wrote:
> On Tue, Nov 07, 2023 at 07:15:10AM +0100, Greg Kroah-Hartman wrote:
>> On Tue, Nov 07, 2023 at 11:27:27AM +0800, Jack Zhu wrote:
>> > 
>> > 
>> > On 2023/10/31 9:09, Jack Zhu wrote:
>> > > 
>> > > 
>> > > On 2023/10/25 11:14, Jack Zhu wrote:
>> > >> Hi,
>> > >> 
>> > >> This series is the v11 series that attempts to support the Camera Subsystem
>> > >> found on StarFive JH7110 SoC.
>> > > 
>> > > Hi Hans and Laurent,
>> > > 
>> > > Could you please help review the code?
>> > > Thank you for your time!
>> > > 
>> > 
>> > Hi,
>> > 
>> > Could you please take some time to help review the code? Thank you so much!
>> 
>> It is the middle of the merge window, no new code can be added to any
>> maintainers tree at this point in time, please relax there is no rush or
>> deadline at all here.
>> 
>> While you wait, why not help out and review other patch submissions from
>> other developers, which will help your changes get to the top of the
>> queue?  That way everyone's load is reduced and you are not just asking
>> for others to do work for you with nothing in return.
> 

Hi Greg,

Thank you very much for your reply!

I'm so sorry for sending emails too frequently in the past two weeks.
I am willing to do something for the community. If you pay attention to my
previous submission records, you will find that I have assisted other
developers in modifying v4l2-compliance bugs. But I think currently I may
not have enough ability to comprehensively review others' submissions.
But I hope I can do something similar through learning later.
Sincere thanks to everyone who commented.

> Also, while you wait, why not just finish off the last 3 items on the
> TODO list which would make your code not be required to go into the
> staging portion of the tree at all?  You've had a few weeks now, what is
> preventing that from happening, and when will that work actually be
> done?
> 

One of my colleagues is doing related development, but he also has other
projects at the same time, so he cannot devote all his efforts to this
development. And we expect to use libcamera, which may take some time.

-- 
Regards,

Jack Zhu
