Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF06D76BC0A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjHASMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjHASMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:12:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1540510E;
        Tue,  1 Aug 2023 11:12:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A01C66166F;
        Tue,  1 Aug 2023 18:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7029AC433C8;
        Tue,  1 Aug 2023 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690913540;
        bh=E4LcPlCQ/o2sDNG8UZOTlAtL4LvKYVDiX+JdRpxfqmY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JveUG0hdxUnDM4IT9enzeTgaYZ7+MvVTnW7hcy4ADnznDv3A/Li4vJqrNQj3Llzzo
         D28mxUnih7FBqBxhveNtQBMDphgQ9LeMdAp4fsIzBE22/IKKNA/5BeHJ011uSa5gX8
         Kums6hdrG9Y7I4mCLsGy+eNLHELMrzN2BiBK4W6hYlUe3sFrSFhkew6vG+gWB0vVYj
         +c6z3FvSivA2QO9k2hcad7Pjj48ZfHNlj6wchcvRvwRF60hmS0OPPeFCYY4PVPNslf
         QxttEwTpEJ5Yy45Ix79crvW2KJ/LwylSUiqlt2vnrVeicq7iEsTfuAAMdDlNDMNiHb
         W2fUdPd6CMK1Q==
Date:   Tue, 1 Aug 2023 19:12:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: admv1014: make all regs required
Message-ID: <20230801191213.5fde213d@jic23-huawei>
In-Reply-To: <defe7fb9-37b0-df31-9e66-0a126a865813@linaro.org>
References: <20230731144404.389255-1-antoniu.miclaus@analog.com>
        <defe7fb9-37b0-df31-9e66-0a126a865813@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 17:17:59 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 31/07/2023 16:44, Antoniu Miclaus wrote:
> > Make the regulators required in the dt bindings.
> > 
> > Despite the fact that the datasheet is not explicit enough, all the
> > specifications of the part are built around these pins being supplied.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---  
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,

Jonathan

> 
> Best regards,
> Krzysztof
> 

