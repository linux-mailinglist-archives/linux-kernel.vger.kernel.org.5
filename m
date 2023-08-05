Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B267770F55
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 12:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjHEKoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 06:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHEKn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 06:43:58 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9822468A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 03:43:56 -0700 (PDT)
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 375Ahs9K034135;
        Sat, 5 Aug 2023 19:43:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Sat, 05 Aug 2023 19:43:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 375AhmiF034121
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 5 Aug 2023 19:43:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8fd13a0a-4724-db17-f52f-3adb72868745@I-love.SAKURA.ne.jp>
Date:   Sat, 5 Aug 2023 19:43:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] Documentation: changes.rst: add entry for git
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230803090711.2261876-1-linux@rasmusvillemoes.dk>
 <2023080302-theology-custody-670b@gregkh>
 <CAK7LNARPTwmnTO-saaGo4nnc7HXK44qQihRK+EqovK=qFT8zPg@mail.gmail.com>
 <2023080447-ahead-tannery-c77a@gregkh>
 <CAK7LNAQdYRuvM8t8rr=DysC_wt2QbhWqaCwnNvkrSHb5c0HWMw@mail.gmail.com>
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAK7LNAQdYRuvM8t8rr=DysC_wt2QbhWqaCwnNvkrSHb5c0HWMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/08/05 17:02, Masahiro Yamada wrote:
>>>>> It's useful to have some minimal git version one can expect people to
>>>>> use. For now, set a somewhat conservative minimum of 1.8.0, which is
>>>>> already more then ten years old.

No problem with requiring git >= 1.8.0.

> 
> The default GCC on CentOS 7 is GCC 4.8,
> which is too old to build the kernel.
> 
> I am not so sure how RHEL/CentOS 7 users are working
> on the kernel development, but it is possible to
> install a newer gcc version from Developer Toolset.

CentOS 7 users can install a newer git version as well as gcc.

> commit f5983dab0ead92dc2690d147f0604a0badcac6a8
> Author: Masahiro Yamada <masahiroy@kernel.org>
> Date:   Wed Jun 28 01:32:05 2023 +0900
> 
>     modpost: define more R_ARM_* for old distributions
> 
>     On CentOS 7, the following build error occurs.

It is glibc-headers-2.17-326.el7_9 package. Neither gcc nor git problem.

