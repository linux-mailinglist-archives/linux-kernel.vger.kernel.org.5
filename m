Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6D37F97EC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 04:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjK0DXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 22:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjK0DXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 22:23:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E2B126
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 19:23:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2CBC433C8;
        Mon, 27 Nov 2023 03:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701055430;
        bh=UqWQSWnQlFHOXDahR564UiFu2gmiWejxDC1l3SAOMXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jn12v7RVQ4Ba0wCENEspHXptscLisqAvzw+o+5umafgEq9jS4qGcqMPikPwsQz7sR
         qtNGQV4TjmOKCq6Y0wlWrSWWj/NlBGZGNHAgavlYvZ7RAN+biYUvZlpafsPKXZywLu
         zO4axk2yWs02724c2KqE7iW0+1crTyirVztjMPJ5wA5i+TKiuxzulY//5dOfjofytm
         5oUpwUGvB+8XtzDP7CXeLRgDCC1yZKV9jioWaHx/OZQoNr/jCaaLz1T3EQA6xw+00Z
         iaGzI1T1/9/uC9avyBCRKS5gn/F+l3ZulKiydS6wV67/iQQToM0AUujHVjBQFQWxQg
         onK/n7Rp2WnzA==
Date:   Mon, 27 Nov 2023 11:23:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som: add fixed 3.3V regulator for
 EEPROM
Message-ID: <20231127032345.GA87953@dragon>
References: <20231030151920.191018-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030151920.191018-1-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 11:19:20AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> When the EEPROM is probed, we have this warning:
> 
>     at24 0-0052: supply vcc not found, using dummy regulator
> 
> Add fixed 3.3v regulator to silence the warning.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied, thanks!
