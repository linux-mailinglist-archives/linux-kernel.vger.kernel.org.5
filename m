Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCFC7667F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbjG1I63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbjG1I6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:58:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511EBCE;
        Fri, 28 Jul 2023 01:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD1056203D;
        Fri, 28 Jul 2023 08:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C1AC433C7;
        Fri, 28 Jul 2023 08:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690534700;
        bh=dy0eS/EcetnbtqPhA55XszAGHS80QHlhVTv28xSu6U8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bUljFWceS85FeD801v/cYMxAKBIwaze4RJhGjLx0ovtQnx4HfsT8NIrOGsIBmI3dD
         wIAZGxFcYLVV8wUwXmuABFgrooOntC1zoYGdtDySeGoS4PhpjV9jbrUK3jzdPljl+n
         IZTv9O4eAJyiUaCoyJ8DcpdCeBdGfjvzDEDq5q6h+G9+g9zUOmRLiFE42sJdJtyxLF
         NqfJ4oY9vkbuxIBDM/ocDI/pyITIsyqbQJF8qoTkNBmD2cNz/bhb9l0HyEw6LAUUz+
         HxGRqknUmw/4+R11Xoz6A0Afalh9qrJMugD+MvLOHGJfwzG80Iyv0yUgzRjAV6smE4
         DJLvLzL9RdASA==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Henning Schild <henning.schild@siemens.com>
Cc:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        "xingtong . wu" <xingtong.wu@siemens.com>
In-Reply-To: <20230713115639.16419-3-henning.schild@siemens.com>
References: <20230713115639.16419-1-henning.schild@siemens.com>
 <20230713115639.16419-3-henning.schild@siemens.com>
Subject: Re: (subset) [PATCH v2 2/2] leds: simatic-ipc-leds-gpio: add
 Elkhart Lake version
Message-Id: <169053469756.286844.11708875403893283992.b4-ty@kernel.org>
Date:   Fri, 28 Jul 2023 09:58:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 13:56:39 +0200, Henning Schild wrote:
> This is used for the Siemens Simatic IPC BX-21A, which has its LEDs
> connected to GPIOs provided by the Intel Elkhart Lake pinctrl driver.
> 
> 

Applied, thanks!

[2/2] leds: simatic-ipc-leds-gpio: add Elkhart Lake version
      commit: 7e6d86e99a5dee6f81e39f1f6d57091503dc7593

--
Lee Jones [李琼斯]

