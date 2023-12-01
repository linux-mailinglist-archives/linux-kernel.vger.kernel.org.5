Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0ED8002B2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377352AbjLAFEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjLAFEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:04:22 -0500
X-Greylist: delayed 406 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 21:04:26 PST
Received: from mail-m92230.xmail.ntesmail.com (mail-m92230.xmail.ntesmail.com [103.126.92.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB30D4A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 21:04:26 -0800 (PST)
Received: from [172.23.111.174] (unknown [111.52.6.202])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 146848000EB;
        Fri,  1 Dec 2023 12:56:15 +0800 (CST)
Message-ID: <9075f00e-f914-4739-aae2-ba4ccfd6236b@link.tyut.edu.cn>
Date:   Fri, 1 Dec 2023 12:56:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/show_delta: reformat code
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        masahiroy@kernel.org, ndesaulniers@google.com, n.schier@avm.de,
        ojeda@kernel.org, linux-kernel@vger.kernel.org
References: <20231130143822.17173-1-2023002089@link.tyut.edu.cn>
 <CANiq72nS9_uPXNXc6mORtWsBEUB7JBWeUW+aAQ0Osqnca3vaVA@mail.gmail.com>
Content-Language: en-US
From:   Hu Haowen <2023002089@link.tyut.edu.cn>
In-Reply-To: <CANiq72nS9_uPXNXc6mORtWsBEUB7JBWeUW+aAQ0Osqnca3vaVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQx4YVk4fQhpCQ09JGRlPSFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKSlVOSVVNVUlLSVlXWRYaDxIVHRRZQVlPS0hVSkpLSEpDVUpLS1VLWQY+
X-HM-Tid: 0a8c23bc0b2cb03akuuu146848000eb
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PEk6GDo6DzwrChY1HU0vPywM
        KAMwClZVSlVKTEtKT0tNTkxOQkxDVTMWGhIXVUlLSUhLS0lLQ0I7FxIVEFUPAg4PVR4fDlUYFUVZ
        V1kSC1lBWUpKSlVOSVVNVUlLSVlXWQgBWUFJTktONwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/12/1 01:13, Miguel Ojeda wrote:
> On Thu, Nov 30, 2023 at 3:49 PM Hu Haowen <2023002089@link.tyut.edu.cn> wrote:
>> -                               if string.find(rest, base_str)==1:
>> +                               if string.find(rest, base_str) == 1:
> If this is changed, shouldn't be others like:
>
>>                  if arg=="-b":
>>                  elif arg=="-h":
> be changed too?


Sorry, ignored by accident. I'll make up within the next patch version.


> In other words, it seems this was done manually. Should we instead
> introduce/use something like Black or Ruff if we are going to do this
> sort of changes?


I'm sorry but I'm not familiar with these two things. Are Black and Ruff
some kind of tools which help identify these code format issues? If so
it is better to introduce them to assist to accomplish the similar
series of work instead of only completing it manually with avoiding
omitted parts simultaneously.

Thanks,
Hu Haowen


> Thanks!
>
> Cheers,
> Miguel
>
