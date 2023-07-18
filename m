Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2997574F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjGRHHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjGRHG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:06:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421031BE;
        Tue, 18 Jul 2023 00:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C52DF60B79;
        Tue, 18 Jul 2023 07:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0666EC433C9;
        Tue, 18 Jul 2023 07:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689664017;
        bh=ohiSxSV5BnWHAEeRIhDJnnbukX+huXSkLYSDq36RrHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T06KZliokg+MgRtPfquZpRLUeRUf34v+Q0PnLs6dfTNnPFnDWGWwIOR+pRicRC1IT
         pyXsegT0FwgxEBwe0HxigEc6ApM148oUDO3292rIKvlRYqDZNh6fCmEM8W+4PQ/HQp
         CQyRNpvzSsdoz4Hkq8z7GwmwebxpgAF90tezqMFyLpU/ijUsSWgKPiGHlrElti817B
         oHmvRsGiwqIjMCh86acEMz8xBr7ie1/bTHXoEwVWDZNY3pE0wg/l6nUI0HTC/6A8I/
         EKGSLrezE3DbT07DxQ7J0PWyYH9lpiPMGnaga6HD47HoFxrDyQlrq70F5lJ4SkS6Yw
         754L+MttNk6mg==
Date:   Tue, 18 Jul 2023 15:06:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        kernel@collabora.com, kernel@pengutronix.de,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] ARM64: dts: freescale: Fix VPU G2 clock
Message-ID: <20230718070642.GP9559@dragon>
References: <20230707094200.47119-1-benjamin.gaignard@collabora.com>
 <16cbecde-3622-0525-f5f8-9198ac357c06@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16cbecde-3622-0525-f5f8-9198ac357c06@web.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 12:08:34PM +0200, Markus Elfring wrote:
> > Set VPU G2 clock to 300MHz like described in documentation.
> > This fix pixels error …
> 
> Would you like to avoid typos in such a change description?

I assume you are suggesting s/fix/fixes?  I can fix it up when applying.
Thanks!

Shawn
