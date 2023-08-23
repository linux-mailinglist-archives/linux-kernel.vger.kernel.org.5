Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3903178595E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbjHWNaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbjHWN3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:29:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC1319AB;
        Wed, 23 Aug 2023 06:29:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89B72662F0;
        Wed, 23 Aug 2023 13:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABDBC433C7;
        Wed, 23 Aug 2023 13:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692797338;
        bh=4S6Dk3MvfyLnIMCYyIMYZa7VyYaWFKn+GW5De/l6gb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lmWEM5kMysx6okcHxfvdYNKoLGlgk7dAfV8gYV08JGtY0LZkmIQtlhj2K+/BJ9cdq
         HA00wzfCi2fB1af7R1Rz9zf6NnTZ+9ZYMlKbyoI91Z9JOJH779sXSiX/S2UJZU4IW2
         t+sxf2lOfREPzgjdVMMCOpwfuptbHWiA+RkDxvpRs44Lu98ev6YXuqvJq0dis4Qst1
         W/Wv2GtnkGleAuhVWHD5kYiV9GDs5OapSj8YCSr3Ls2a4+8EyihYYfWggnHA7mOmin
         sYnyQAGShxeFzAZCVARMYAo+Bchkjhq6WKXk27Qc98ZL1jZKJ4DSJPEexY8SHG4N8p
         ayku6VhCvPt2Q==
Received: (nullmailer pid 2214579 invoked by uid 1000);
        Wed, 23 Aug 2023 13:28:56 -0000
Date:   Wed, 23 Aug 2023 08:28:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] dt-bindings: display: advantech,idk-2121wr: reference
 common panel
Message-ID: <169279733533.2214500.4453589931480944144.robh@kernel.org>
References: <20230823081107.82967-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823081107.82967-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Aug 2023 10:11:07 +0200, Krzysztof Kozlowski wrote:
> Reference common panel bindings to bring descriptions of common fields
> like panel-timing.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/display/panel/advantech,idk-2121wr.yaml           | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!

