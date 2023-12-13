Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D858117B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442539AbjLMPmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442635AbjLMPm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:42:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185DAD56
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:42:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AB6C433C9;
        Wed, 13 Dec 2023 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702482146;
        bh=GcusTtDa/xUz/eWeRnRe/jGZ7M5e05jlT9WsJ3wX1Aw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ffta2sAir1jM4m+st2G1XjKJwbMxZHgj5f/t5FIM8J+TcIpJrMm8ZOXt4C8IZbTZ0
         4/6nUIZ29UyleFKeoEJh151Bb5llzinRSD+j7HupWYTI0AUbMDl3X+25t/AeCfiAPj
         qRgrcm+QNlJaBI+gdjJ5TxOLmrGcWtiyXdzbHBVrLS2d3YhZhGOe0c3yDWjAAPGO+N
         V96sYnmzxLWgMsOkZOCKuBHivNFd8XHm/eEGh0c9dhTahunm4NCvdY35yMb/XSiKhG
         13Rb3fQ5R2FdKldI6F1mbkyCiZ/FM62m3qEwDmsjVfUh7Sar3EBewWHexBp8X3JSel
         gGGnrJxo0E0BQ==
From:   Lee Jones <lee@kernel.org>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
In-Reply-To: <20231207161513.3195509-2-andriy.shevchenko@linux.intel.com>
References: <20231207161513.3195509-2-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v2 1/1] backlight: hx8357: Convert to agnostic
 GPIO API
Message-Id: <170248214388.988965.2531555627636674132.b4-ty@kernel.org>
Date:   Wed, 13 Dec 2023 15:42:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2023 18:14:32 +0200, Andy Shevchenko wrote:
> The of_gpio.h is going to be removed. In preparation of that convert
> the driver to the agnostic API.
> 
> 

Applied, thanks!

[1/1] backlight: hx8357: Convert to agnostic GPIO API
      commit: 7d84a63a39b78443d09f2b4edf7ecb1d586379b4

--
Lee Jones [李琼斯]

