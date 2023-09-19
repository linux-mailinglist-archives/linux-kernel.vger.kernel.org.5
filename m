Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F2B7A5FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjISKrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjISKrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:47:18 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F198111C;
        Tue, 19 Sep 2023 03:47:10 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so14115898a12.1;
        Tue, 19 Sep 2023 03:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695120429; x=1695725229;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXV2+Y0J/079ElD38rTTba8O0hPp339AVJF54BgtAFA=;
        b=CesPj0d51889ASsLjJla2MDKLQsfDEU/h4XaRezMcLHASOKVulUvXuU1ZaJFkJhLOS
         Rwa6n2UNmFJC5Cr1fUTQTpP1t6vivq5LeVF5k1Hhd9QWGpwDXi+fquHgkpQu3PUQnz0C
         OhBWdK1NPiGGstS202QXvxfk9a0XcRhTpe0X5bZWHiWQDFW9XDY75TcjDv6sa8klnaQU
         5FewSJHtHq73BzbEH5/8Wi4AJCoxdFYwihlWG6EdT7VFMrp2ChTL3g86kfnFJ+Q4LAXe
         DLxBWvsYerMEMh3mQ4Z0aJFPGFqL9yQ2yCwKculXe+g6tMiIRur6egVRiZwD5tJFq4O5
         b2dQ==
X-Gm-Message-State: AOJu0YwuZyjdA4UfZX+hYn4E3OIsyL7Xy5UYKWU6IhPGOTaoCVwidtLJ
        txN6f9D/58/3G0JfjTu77i0=
X-Google-Smtp-Source: AGHT+IFtzzaBlOq/0vorkvQpCzSjhbUHAn0OGpC0rkqR+QeqUDsAFaNLINKrzArIHszTyKOvolbPcw==
X-Received: by 2002:a17:907:9690:b0:9a5:b247:3ab with SMTP id hd16-20020a170907969000b009a5b24703abmr3024157ejc.19.1695120429165;
        Tue, 19 Sep 2023 03:47:09 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id oq8-20020a170906cc8800b0099bc08862b6sm7806263ejb.171.2023.09.19.03.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 03:47:08 -0700 (PDT)
Message-ID: <6d06e531-6c69-47ca-9832-fac21ce6964c@kernel.org>
Date:   Tue, 19 Sep 2023 12:47:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] tty: fix kernel-doc for functions in tty.h
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230919085156.1578-1-jirislaby@kernel.org>
 <20230919085156.1578-10-jirislaby@kernel.org>
 <6033668f-71cc-b21-a034-a1ff31d7279@linux.intel.com>
 <ae486636-c075-41d9-9304-b0cfb07c132c@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <ae486636-c075-41d9-9304-b0cfb07c132c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 09. 23, 12:45, Jiri Slaby wrote:
> On 19. 09. 23, 12:07, Ilpo Järvinen wrote:
>> On Tue, 19 Sep 2023, Jiri Slaby (SUSE) wrote:
>>
>>> tty_kref_get() is already included in Documentation, but is not properly
>>> formatted. Fix this.
>>>
>>> tty_get_baud_rate() is neither properly formatted, nor is included. Fix
>>> both.
>>>
>>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>>> ---
>>>   Documentation/driver-api/tty/tty_ioctl.rst |  3 +++
>>>   include/linux/tty.h                        | 21 +++++++++------------
>>>   2 files changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/Documentation/driver-api/tty/tty_ioctl.rst 
>>> b/Documentation/driver-api/tty/tty_ioctl.rst
>>> index 9b0be79fc15e..3ff1ac5e07f1 100644
>>> --- a/Documentation/driver-api/tty/tty_ioctl.rst
>>> +++ b/Documentation/driver-api/tty/tty_ioctl.rst
>>> @@ -5,3 +5,6 @@ TTY IOCTL Helpers
>>>   =================
>>>   .. kernel-doc:: drivers/tty/tty_ioctl.c
>>> +
>>> +.. kernel-doc:: include/linux/tty.h
>>> +   :identifiers: tty_get_baud_rate
>>> diff --git a/include/linux/tty.h b/include/linux/tty.h
>>> index 59d675f345e9..4b6340ac2af2 100644
>>> --- a/include/linux/tty.h
>>> +++ b/include/linux/tty.h
>>> @@ -390,14 +390,12 @@ int vcs_init(void);
>>>   extern const struct class tty_class;
>>>   /**
>>> - *    tty_kref_get        -    get a tty reference
>>> - *    @tty: tty device
>>> + * tty_kref_get - get a tty reference
>>> + * @tty: tty device
>>>    *
>>> - *    Return a new reference to a tty object. The caller must hold
>>> - *    sufficient locks/counts to ensure that their existing 
>>> reference cannot
>>> - *    go away
>>> + * Returns: a new reference to a tty object. The caller must hold 
>>> sufficient
>>> + * locks/counts to ensure that their existing reference cannot go away
>>
>> Shouldn't this have also Locking: entry instead of hiding the details 
>> into
>> Return?
> 
> /me left to fix both in a separate patch.

Ah, no. The Locking Alan introduced means what _this_ function locks. I 
am not sure we want to extend the meaning to _expected_ locks?

thanks,
-- 
js
suse labs

