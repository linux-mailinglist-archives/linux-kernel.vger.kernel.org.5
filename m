Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581947DAC59
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 13:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjJ2MOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 08:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJ2MOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 08:14:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B518BBE
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 05:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=IrZdwObbGIKWh/WDVQ2jOCxaRN5W4wRKYpNtWgqSq7w=; b=JX1XBcKUmtBoQ6JhrwNpZad1W+
        tdm0FmMmA5yZv5rvmL0Uighwfgno2d39tUsIZpZCI6SdGr6ltAWG79Cby4t0GbSum4SUrLkoDM4WI
        qiFt1/4MlYFy9Y4yODp3yqk9q6d5WDLtRz2M2Y/JPrfo+GmX8a+OiYDlxh7QKsE5rrDMy/wcIq47O
        LnQb76lmUUpdzR+9dGaE/2GGrElLVYBJqnmmRQtlIAPrPNDIHJra4VcY3d6l4TOofVa099wq7IMvp
        OFYtf7DRRZpBTWXSuQgwpBYW5486tkKu0e/O41E9bSwVnEg+gD/k8Pdk2ewwfW7MVovcKDNpBmPj6
        FYV2BBZQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qx4fx-001j0Z-2K;
        Sun, 29 Oct 2023 12:13:53 +0000
Message-ID: <5265031c-14b3-4526-8d30-75edbf804a38@infradead.org>
Date:   Sun, 29 Oct 2023 05:13:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gnss: tell what GNSS means
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>, Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230925054346.18065-1-rdunlap@infradead.org>
 <ZS1K5AoZnS-3H-c3@hovoldconsulting.com> <ZT4GnZUUVy0Ri5rS@duo.ucw.cz>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZT4GnZUUVy0Ri5rS@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/23 00:15, Pavel Machek wrote:
> On Mon 2023-10-16 16:38:28, Johan Hovold wrote:
>> On Sun, Sep 24, 2023 at 10:43:46PM -0700, Randy Dunlap wrote:
>>> Tell users what GNSS means in the Kconfig prompt.
>>  
>>>  menuconfig GNSS
>>> -	tristate "GNSS receiver support"
>>> +	tristate "GNSS (Global Navigation Satellite System) receiver support"
>>
>> No, I don't like the way this clutters menuconfig. The above would make
>> this one of the longest entries and for very little gain.
> 
> Yeah, because everyone knows what GNSS means.
> 
> Except that most people know GNSS as GPS. You misnamed the subsystem,
> so it now needs explanation :-(.
> 								Pavel

Thanks.  Obviously I agree.

-- 
~Randy
