Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E927791B7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjHKOWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbjHKOWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:22:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B53C10E4;
        Fri, 11 Aug 2023 07:22:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A368965E66;
        Fri, 11 Aug 2023 14:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20307C433C7;
        Fri, 11 Aug 2023 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691763738;
        bh=Iror0DkK6V6ibqchZbAfsiBt2VvvDldfmk9oKu7PAlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nTsKZPJ2wxsRFCE4DNbxiEz/oVi6pGsicd2EPrZt+pk0F7HV03J4W8Janex5KPtZ+
         0WVo4pxDjHcLMKrhWqG8F5OvRWlE1QOa2lmaW37rxGiJ3HNHvVrXcXxrTapNEYwRLm
         SIRytOOyg2cgXa8SPKlwMCDYVBxURSP5VeGJOZPF6BPKdNXislWKX10NVyXhoC3aTg
         HNLL0nEvUHSngOn/TpnPqvLf2FBu5i5RoynqUbfQWVk3qDmOrrVsjMdORb7+59oDYM
         9pZ0zcmmbVi0o/tywjZoFUQmnJr9mr9ob79iyY9YQz7MnaaLc2jVSTx63Dx5NqvpEX
         pNnHi4FhAwBlA==
Date:   Fri, 11 Aug 2023 22:22:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, laurent.pinchart@ideasonboard.com,
        dan.scally@ideasonboard.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/4] arm64: dts: imx8mp-debix: remove unused fec
 pinctrl node
Message-ID: <20230811142206.GZ151430@dragon>
References: <20230809071026.3546605-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809071026.3546605-1-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:10:23AM +0200, Marco Felsch wrote:
> The SoM A uses the EQOS ethernet interface and not the FEC, so drop the
> interface pinctrl node from the device tree.
> 
> Fixes: c86d350aae68 ("arm64: dts: Add device tree for the Debix Model A Board")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Applied all, thanks!
