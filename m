Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF44757268
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjGRDiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjGRDit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:38:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F58F4;
        Mon, 17 Jul 2023 20:38:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFD92613FB;
        Tue, 18 Jul 2023 03:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD4FC433C8;
        Tue, 18 Jul 2023 03:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689651528;
        bh=ny9uqMXSwYkXmAxjV/H8mJOqiUhLBjxz3ew6fMA8gdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HUbU4hdv52Phwwm2+puFN8PKrpLbosrvhxaSwYf4VLL9ZqV7Hn2l0W8xFoYnP6qoC
         eL2TiCZo0yIJwqfxtCy+2UoL/W7G42lHkcRJBKmwxuEOzS7xSu1mb9koyj9PX7+aBS
         /T9/MW9Mtd/LlcveFvY/qFPBZwlKpb8HVenEEWDZvhOYEXFdorqXeXrHlO6xY7qTj/
         dnEETUuEyd02mFG97JKUJ6EhFrcSOC/s9x/aR9aKf/RxcOFSOmk1uLEcy2LUP1LZ67
         YnFAarUQXfQ3tmAqVCnHwnVbkutnMVQl/dO3XyGvS8UsS0Qv6QBRyv6ugcL9cF1bh5
         OuzGnqS2d1ecQ==
Date:   Tue, 18 Jul 2023 11:38:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        shenwei.wang@nxp.com, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH V3 2/3] arm64: dts: imx93: add "fsl,imx8ulp-lpuart"
 compatible for imx93
Message-ID: <20230718033836.GG9559@dragon>
References: <20230627025332.11133-1-sherry.sun@nxp.com>
 <20230627025332.11133-3-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627025332.11133-3-sherry.sun@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:53:31AM +0800, Sherry Sun wrote:
> i.MX93 and i.MX8ULP lpuart add some new featurs based on i.MX7ULP, for
> example, i.MX93 and i.MX8ULP can support EOP(end-of-packet) function
> while i.MX7ULP doesn't support, so add "fsl,imx8ulp-lpuart" compatible
> string for i.MX93 to support those new features.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Applied, thanks!
