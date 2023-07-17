Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D74755945
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 03:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjGQB4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 21:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjGQB4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 21:56:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970CA122;
        Sun, 16 Jul 2023 18:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=xMRnYmk86/00EipHZokRGRoYxS0eKfzaI1ekzyVLMRA=; b=F7zeAQS7fYDK978HNbr0FF3CcJ
        vRT7UQ1SnLvPebR24PNxUQgcwUMjSbXRZX00SbSy5bkAFO3lv2q9N1pbsuhrQBfGBdRD2TQCTB6vK
        59gdX0iqCNq58tETRJ2S0XjogMbs9KmDMQhfpH9s9+uhrMHffNyTdVWNQ+nvI/yvuZnnSJyo8WVNj
        zAFXA7xpubaYf9CLGk27CtlNyAfk3A2RZPyi/rk8JYqri8CHjCbvqiriuDzoadRarcnH3EuA2FzoW
        AancCyFXTXaCqDwUa1XEARi/8Zu/JP6gnbgMoDm5PsJCsFgDhFrIskrw+QoPYEYRl+RkU2flhR43z
        ELf/HuSg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qLDT8-000WPg-22;
        Mon, 17 Jul 2023 01:56:10 +0000
Message-ID: <186adfa4-d2bb-95d1-a079-8602d6e516a7@infradead.org>
Date:   Sun, 16 Jul 2023 18:56:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 02/13] Add TSEM specific documentation.
Content-Language: en-US
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230710102319.19716-1-greg@enjellic.com>
 <20230710102319.19716-3-greg@enjellic.com>
 <ab6ab3d2-d168-8c10-b7f5-94a669e212fc@infradead.org>
 <20230717003654.GA3044@wind.enjellic.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230717003654.GA3044@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/23 17:36, Dr. Greg wrote:
> On Mon, Jul 10, 2023 at 09:37:10PM -0700, Randy Dunlap wrote:
> 
>> Hi--
> 
> Good morning, I hope the week is starting well for everyone.
> 
> 
> That must have been an untoward effect of the single-malt.
> 

Mine are more often from double or triple or imperial IPA. :)

> The documentation has been updated to read as follows:
> 

Thanks for the updates. They look good.

-- 
~Randy
