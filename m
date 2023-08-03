Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E146E76DF85
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjHCFEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjHCFED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:04:03 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABC330F1;
        Wed,  2 Aug 2023 22:04:00 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so497577f8f.1;
        Wed, 02 Aug 2023 22:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691039039; x=1691643839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9ZnReRkIatzrcYgj5JzpsMcAWQyZ8o9F9DDy3PX+rI=;
        b=CyFMu70sizZQYb+1hHDYCeH62YNcl4ZW+hVT9wYWC2HAUTNG7QOj/g9sBTdKCJPmXI
         1f1GmUx+n/5xcdinJ4AKQxu/KxDkMO6QOLUnbdjdcfkpe03iTz7cbmI9ZkxQhK+nUCn/
         S6YUx+BQ0LHFTA+E/FXgDKIbug2YxC3BZnuTxJsOlRVFK526HLY7h7+dU1BiI3QxvEoO
         denbeVP/2oniuMmvDLY1XKcsxFYfYE0viCY+7yMnE+rTChHAwPIr+SABWEe4jdVIjBTX
         PXAOT4pTBUbNQRH81DVrfdL8QkPgU6BNCEOBTvyO5iEg60qTd3ZtTQTJ4WdzyrThH9HC
         DHkw==
X-Gm-Message-State: ABy/qLbsgph1yESw3n5yhXvg2VR9/h3cbCh7akqB0M5yi+UkexIsX47U
        hyXxpFmzCbbnUclMIY4GpKk=
X-Google-Smtp-Source: APBJJlHHZBPvSNoWe46vU35lSlLEH0299lo02WJ9EtQxELEcNQXj1iOlxtND+QC/G5PDc5zpIxVLZQ==
X-Received: by 2002:adf:ef46:0:b0:313:f704:5450 with SMTP id c6-20020adfef46000000b00313f7045450mr6733850wrp.38.1691039038637;
        Wed, 02 Aug 2023 22:03:58 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600012d200b0031753073abcsm20674727wrx.36.2023.08.02.22.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 22:03:58 -0700 (PDT)
Message-ID: <651e47f9-821f-9947-f453-4288cc4e4d9a@kernel.org>
Date:   Thu, 3 Aug 2023 07:03:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] MAINTAINERS: Update TTY layer for lists and recently
 added files
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230721072334.59272-1-tony@atomide.com>
 <ZLpboaXKVOOjeGJ+@smile.fi.intel.com> <20230724045327.GV5194@atomide.com>
 <2023072517-onward-payment-569d@gregkh> <2023072530-wired-chaps-c1e3@gregkh>
 <edb0414f-3808-8651-4956-8ec34b056901@kernel.org>
 <20230802120530.GE14799@atomide.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230802120530.GE14799@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 08. 23, 14:05, Tony Lindgren wrote:
> * Jiri Slaby <jirislaby@kernel.org> [230726 10:12]:
>> On 25. 07. 23, 19:29, Greg Kroah-Hartman wrote:
>>> On Tue, Jul 25, 2023 at 07:28:46PM +0200, Greg Kroah-Hartman wrote:
>>>> On Mon, Jul 24, 2023 at 07:53:27AM +0300, Tony Lindgren wrote:
>>>>> * Andy Shevchenko <andriy.shevchenko@intel.com> [230721 10:19]:
>>>>>> On Fri, Jul 21, 2023 at 10:23:32AM +0300, Tony Lindgren wrote:
>>>>>>> Add mailing lists for linux-serial and lkml for the TTY layer. And let's
>>>>>>> list the recently added files. This makes it easier for get_maintainer.pl
>>>>>>> to include linux-serial for patches.
>>>>>>
>>>>>> Shouldn't serial_* stuff go to the "SERIAL DRIVERS" section?
>>>>>
>>>>> Not sure if there's some reason we have "TTY LAYER" with serial_core
>>>>> files. If not, yeah let's move the serial files.
>>>>
>>>> I'll take this patch, can you send a new one that removes the serial
>>>> files from this entry as I don't think they are needed in here anymore.
>>>
>>> Better yet, they should be merged probably.  Although I don't know if
>>> Jiri wants to be responsible for serial stuff, that's his call...
>>
>> No problem. I actually didn't realize they are separate. So feel free to
>> submit a patch, so we have a single MAINTAINTERS file entry...
> 
> How about something like this?

Acked-by: Jiri Slaby <jirislaby@kernel.org>

-- 
js
suse labs

