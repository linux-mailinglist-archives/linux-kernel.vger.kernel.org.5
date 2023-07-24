Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04D87602D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjGXW4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjGXW4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:56:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C7A10E6;
        Mon, 24 Jul 2023 15:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Xv427QC+R9vuHVbHCAZjuC2UpYowC4hp3LnREUt/91U=; b=OkjBl1DEAv9p/qikIyDaijwxe/
        K2tZlk2NPbdwFenUZrX9RMAUdmQj5o4fzjJ/xvhB5g324dyytttePLevseSmopf9vl2V2gcGevDVU
        GBlWond5QEtZLgq8igwjBDgsmbSSh3c6xjMW5Me2hcJj1FV3U4dT11mNuiefaVtHtUrXjM/KtWFA/
        7pUEoUip650uHAzBJvdFP+S1Bvr8qd2EIRPH3OH25kO04CaiugnhPhE1/9BP0OKdWwYHp+rKaO4kc
        GVthT7i+7EebQyq0guGPOYNf6jIQGJ8mStSDOaMgCvTi3bl+c+CcFaqRa7jwZPXHERnZUBirmAqvT
        kQsViwvQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qO4TA-005bDi-1n;
        Mon, 24 Jul 2023 22:56:00 +0000
Message-ID: <489f5b97-36fb-75fa-c6eb-c9b36fd116a0@infradead.org>
Date:   Mon, 24 Jul 2023 15:55:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/6] gpio: ge: fixes and cleanups
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
References: <20230724161320.63876-1-andriy.shevchenko@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230724161320.63876-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/23 09:13, Andy Shevchenko wrote:
> Randy reported a couple of problems, the first two patches
> fix that. On top are a few cleanups.
> 

For the series:

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> Andy Shevchenko (6):
>   gpio: ge: Add missing header
>   gpio: ge: Fix English spelling and grammar
>   gpio: ge: Make driver OF-independent
>   gpio: ge: Utilise temporary variable for struct device
>   gpio: ge: Replace GPLv2 boilerplate with SPDX
>   gpio: ge: Enable COMPILE_TEST for the driver
> 
>  drivers/gpio/Kconfig   |  2 +-
>  drivers/gpio/gpio-ge.c | 66 +++++++++++++++++++-----------------------
>  2 files changed, 30 insertions(+), 38 deletions(-)
> 

-- 
~Randy
