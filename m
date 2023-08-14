Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649C977B807
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjHNL5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjHNL5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:57:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3AD1715;
        Mon, 14 Aug 2023 04:56:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFF2063537;
        Mon, 14 Aug 2023 11:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6CDC433C9;
        Mon, 14 Aug 2023 11:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692014160;
        bh=ZFYgQNnko81pe6dmbGRQJatjXxAp4LnDUhog6PqJ0f0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OU5ojADaxGxwEGzc4QYOzIrvU4WgogQcLkPyeK/BVCXZA4C/hm91prZZydZuA2eod
         lAK3E7B5BCv4XMhXBoa5D75pUK4Pdnso5Ju/jM94UlTGisru2tfk+4R1p5FTD6zRHs
         zFLF99F891qHntoiiChhGs6nWbIdXXmgbKTzwPEEKxPufkRY2YfNrKysOIStR058jb
         fjvBWzQe8GTjvfFmJJ3W+w1Sg8XJzxqgXLyJH1X7Fwv0nOKbICDOHmMXHgQiQjhVeG
         xvxbIewKEzsmYMzWKPMA5kohziTpBBLzySNxlnL04UeATf/F7F81rXBtUneaOiR+8x
         Sv2s987zaLELA==
Date:   Mon, 14 Aug 2023 13:55:56 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: regression from commit b0ce9ce408b6 ("gpiolib: Do not unexport
 GPIO on freeing")
Message-ID: <20230814135556.5a2c08c3@dellmb>
In-Reply-To: <ZNoNgWQG/5jdXlCK@smile.fi.intel.com>
References: <20230808102828.4a9eac09@dellmb>
        <ZNYKjnPjIRWIYVot@smile.fi.intel.com>
        <20230814093934.1793961e@dellmb>
        <ZNoNgWQG/5jdXlCK@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 14:18:25 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Aug 14, 2023 at 09:39:34AM +0200, Marek Beh=C3=BAn wrote:
> > On Fri, 11 Aug 2023 13:16:46 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote: =20
>=20
> ...
>=20
> > tested, works. =20
>=20
> I convert this to the Tested-by tag, I hope you won't object.
> But tell me if it's the case.

Yes, Tested-by, maybe even Reported-by.

Marek
