Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC0D80CE96
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343807AbjLKOmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343710AbjLKOm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:42:29 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 597F19F;
        Mon, 11 Dec 2023 06:42:36 -0800 (PST)
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 5ED261A367B;
        Mon, 11 Dec 2023 15:42:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1702305755;
        bh=wKD1DsQaiTgywzlVHLaJwdfwwxmFpo+Zt21eDIlz2CI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0+AhFQH1wPogqKg67e1JEaiJg745C9js2v9TdhpvbOkZXYxEBm79UkKR52gD7YDXf
         1td4YdH0NLUoESa1Iq2c9r9SNFfDJI1ie5bu7/bxwdFR/xkjnZrr2ogsmX8T/t9wpW
         NWzn3t6edKbTjoLetjerEy6Z6MP5wheSH4QuG1bVJWmags8+LYpHM7f+TVy7t6dBIu
         9Sey2qUVC3jy0gg0tHWh60Htv5UfvCu1CXCreAfiwlxPl068PHv8HVJkMg+o8QpzR5
         CBuHMlsQjApEFC9ejcrjZuooP24zMeNa6A+3xtNL5BtyTXA7Aw16QrOYFl1dQJQOIB
         niDT8zIVptMnw==
Date:   Mon, 11 Dec 2023 15:42:34 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iommu/apple-dart: Fix spelling mistake "grups" ->
 "groups"
Message-ID: <ZXcf2nB9enlctvTF@8bytes.org>
References: <20231209231240.4056082-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209231240.4056082-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 11:12:40PM +0000, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/iommu/apple-dart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

