Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD7B7F9798
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjK0Cn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjK0Cnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:43:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17381123
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:44:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C87C433C9;
        Mon, 27 Nov 2023 02:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701053041;
        bh=7Q1Qx7ZpLNvlbsCCkhDsZ4gRF/0ixQKTOnZ5pDBPdvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S5pkiw6dNZ0lQpd4OPrV1Tejnk/KjJfBmytpGP6FhD87ncpOYLjNDKHSNdIa3opEj
         +W9iZ3l76AaeAwhFBU5h/3eioNa4AVTfWyuEmYbnLzj/9zppmxNbL2gXi7i+EYBxrb
         gotOnUetKnPr88kHTK8LyniF7pjcdIAz97q6mxotPtBA1PfTFWV5SVi7aeEkMZc7in
         J7acibPjJnKkGAw277Q//J2WYkjDUisDZxv2mEPGiOstTwx1hnVcGsjURF3LEMHlMz
         l/YqKOEvJ0FY8NaODH7BqGhwYS39UqHx8eBA29yG/d9X3UQLBFIwE9OYlzE5dtYT6Z
         cSkJ3+4CcElrw==
Date:   Mon, 27 Nov 2023 10:43:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-venice-gw74xx: remove unecessary
 propreties in tpm node
Message-ID: <20231127024356.GO87953@dragon>
References: <20231018181028.2164419-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018181028.2164419-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:10:28AM -0700, Tim Harvey wrote:
> Remove unnecessary #address-cells and #size-cells from tpm node.
> 
> Fixes: commit 531936b218d8 ("arm64: dts: imx8mp-venice-gw74xx: update to revB PCB")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
