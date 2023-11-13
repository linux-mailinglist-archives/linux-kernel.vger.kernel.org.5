Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA9F7E97D3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjKMIfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKMIfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:35:10 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB52C10EC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:35:05 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id EF6226045F;
        Mon, 13 Nov 2023 08:34:47 +0000 (UTC)
Date:   Mon, 13 Nov 2023 10:34:45 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Rob Herring <robh@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 03/12] bus: omap_l3_smx: Convert to platform remove
 callback returning void
Message-ID: <20231113083445.GA5169@atomide.com>
References: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
 <20231109202830.4124591-4-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231109202830.4124591-4-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Uwe Kleine-König <u.kleine-koenig@pengutronix.de> [231109 20:29]:
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.

Please queue along with other bus related patches:

Reviewed-by: Tony Lindgren <tony@atomide.com>
