Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5610277FD66
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354159AbjHQR7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354214AbjHQR7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:59:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA4926BC;
        Thu, 17 Aug 2023 10:59:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A5F36198C;
        Thu, 17 Aug 2023 17:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BA3C433C8;
        Thu, 17 Aug 2023 17:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692295172;
        bh=qzYPW5cbU+GIAmk7TVP23idJ9s55oOoU2LiTCXeHems=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jjVFOl5xDKQ+Ky1cGS9FoQ5MEyeSc/qEX0AqMoEar6uzRoC2Zw/v0+ijL0QMpZl9W
         wTCE6zzP/4AmgdXK9oLJTcX34i7upFwRpacC8zu0jB21iNpUKw/mnFNlCEYDTW8QFu
         4p8atiAt3xy7wUhz9An5SHIlpUJGB3r+pWkewWLQ64KYlgzxxE4viDPw8XakRZ25IF
         hwc9jm8l5e77hZbofkCga5Orn0gYwLXhWLO28bxlbx4hY+Y4AVbYo1Zd/X9Gs/C6RJ
         3iCroqRP+/jaAoKfG/bYYqFMB/6E6cZreUfGIwwdls6yVqrDImwV2CTZkkVtuZFYiF
         2hUmRYdOZCWzg==
Received: (nullmailer pid 1873962 invoked by uid 1000);
        Thu, 17 Aug 2023 17:59:29 -0000
Date:   Thu, 17 Aug 2023 12:59:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ivan Mikhaylov <fr0st61te@gmail.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Po-Yu Chuang <ratbert@faraday-tech.com>,
        netdev@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4] dt-bindings: net: ftgmac100: convert to yaml version
 from txt
Message-ID: <169229516847.1873884.10919743242203850661.robh@kernel.org>
References: <20230805135318.6102-1-fr0st61te@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805135318.6102-1-fr0st61te@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 05 Aug 2023 16:53:18 +0300, Ivan Mikhaylov wrote:
> Conversion from ftgmac100.txt to yaml format version.
> 
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> ---
>  .../bindings/net/faraday,ftgmac100.yaml       | 102 ++++++++++++++++++
>  .../devicetree/bindings/net/ftgmac100.txt     |  67 ------------
>  2 files changed, 102 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/ftgmac100.txt
> 

Applied, thanks!

