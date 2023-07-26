Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39A1763335
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjGZKNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjGZKNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:13:00 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A14ADB;
        Wed, 26 Jul 2023 03:12:59 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-99454855de1so954141666b.2;
        Wed, 26 Jul 2023 03:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690366378; x=1690971178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4nqAJ8cUHFLvOLZP8FB7lH4Ac8aa38fDh1pyMJB4zY=;
        b=SoXu9Y9JA521rpkpNnlZWCXWP5EO4O0bPsEWmG5q8/5ckc0S2fKwawtTOy1Q0rR6sL
         xsFmVY5paS7rp42fhRuJCXzqp5/lgnVzsi9dfs/tWk6+8Krqf/ripPEsta8G7Xj5NuAQ
         21RjNqRYszqNPA96Pq5zb/Z3c8liBBkIw84j9JLr/v7bVO7C6toMo1YLbXIcwnqa71lO
         SaWv8F0945F5WXAvR7IYMNLFRBGRJPKIEkS3gCucKAxwu4zORFd4ojJkLREEHPwe54zg
         RtOsfues3LG9HqQP1hOHMhXK7cybYNAPA5tNiDNplLUdpp6hZr/ZaoJP8wUHmwePU8ny
         I86Q==
X-Gm-Message-State: ABy/qLZIhKxgcijX4E+KQdP5RHdlAcs+9YXag22SKCCipLzz8td+C+Tg
        0JKdD7dDlPDw8LDNnEwt6+WQti7F70Q=
X-Google-Smtp-Source: APBJJlHopNj4dI4y9LMxLRnkack7VfrLPTm+TfJaVBuoFWgi/vd45pDkOKAANLm2WjvpaZ1JZaFGDQ==
X-Received: by 2002:a17:907:7759:b0:969:f433:9b54 with SMTP id kx25-20020a170907775900b00969f4339b54mr1289722ejc.39.1690366377486;
        Wed, 26 Jul 2023 03:12:57 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id mh3-20020a170906eb8300b00982b204678fsm9361834ejb.207.2023.07.26.03.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 03:12:57 -0700 (PDT)
Message-ID: <edb0414f-3808-8651-4956-8ec34b056901@kernel.org>
Date:   Wed, 26 Jul 2023 12:12:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: Update TTY layer for lists and recently
 added files
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
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
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <2023072530-wired-chaps-c1e3@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 07. 23, 19:29, Greg Kroah-Hartman wrote:
> On Tue, Jul 25, 2023 at 07:28:46PM +0200, Greg Kroah-Hartman wrote:
>> On Mon, Jul 24, 2023 at 07:53:27AM +0300, Tony Lindgren wrote:
>>> * Andy Shevchenko <andriy.shevchenko@intel.com> [230721 10:19]:
>>>> On Fri, Jul 21, 2023 at 10:23:32AM +0300, Tony Lindgren wrote:
>>>>> Add mailing lists for linux-serial and lkml for the TTY layer. And let's
>>>>> list the recently added files. This makes it easier for get_maintainer.pl
>>>>> to include linux-serial for patches.
>>>>
>>>> Shouldn't serial_* stuff go to the "SERIAL DRIVERS" section?
>>>
>>> Not sure if there's some reason we have "TTY LAYER" with serial_core
>>> files. If not, yeah let's move the serial files.
>>
>> I'll take this patch, can you send a new one that removes the serial
>> files from this entry as I don't think they are needed in here anymore.
> 
> Better yet, they should be merged probably.  Although I don't know if
> Jiri wants to be responsible for serial stuff, that's his call...

No problem. I actually didn't realize they are separate. So feel free to 
submit a patch, so we have a single MAINTAINTERS file entry...

-- 
js
suse labs

