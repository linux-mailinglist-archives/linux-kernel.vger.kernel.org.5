Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DCB7EA9D1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjKNEtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjKNEtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:49:52 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663B21B5;
        Mon, 13 Nov 2023 20:49:48 -0800 (PST)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3AE4nVeO093583;
        Tue, 14 Nov 2023 13:49:31 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Tue, 14 Nov 2023 13:49:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3AE4nV88093577
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 14 Nov 2023 13:49:31 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7c814d59-fd95-40f4-80ba-237bead3de69@I-love.SAKURA.ne.jp>
Date:   Tue, 14 Nov 2023 13:49:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: the fetch of the tomoyo tree failed
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231017163242.62af10b3@canb.auug.org.au>
 <20231114144510.49fd3688@canb.auug.org.au>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20231114144510.49fd3688@canb.auug.org.au>
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

Hello.

On 2023/11/14 12:45, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 17 Oct 2023 16:32:42 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> It failed like this:
>>
>> fatal: unable to access 'https://scm.osdn.net/gitroot/tomoyo/tomoyo-test1.git/': SSL certificate problem: certificate has expired
>>
>> and indeed it expired at 2023-10-16 23:59:59 UTC.
> 
> I am still getting this failure (an so am unable to fetch the tomoya
> tree).
> 

Unfortunately, it seems that OSDN became unresponsive after OSDN was acquired by
OSCHINA ( https://www.oschina.net/news/250642/oschina-acquired-osdn ).

I'm considering migrating to a different platform.

