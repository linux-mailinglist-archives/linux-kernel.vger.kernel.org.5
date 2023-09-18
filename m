Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE45B7A55CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 00:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjIRW3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 18:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRW3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:29:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D2A8F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:29:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED08C433C7;
        Mon, 18 Sep 2023 22:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695076182;
        bh=mDnuLPjnWhvrz7zvBdQofJEYR3fhnCIVsuJPvQIYWUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0JWg6czFfkApL/f7hioO32UamWDOagGvWQf37a9Mb2l7WrLa8zBuJ/npVqllcKa9
         EMMnnuzdwnbaCJ1X369UyMyC0UgpCS3+fQfJUl3K6TVY2jJHBTwZpV9GQOi9nvrxes
         zR72TSXTJMw2dN9Cu309kINL1jk/ZJuelWIJ0vy9xm/5Omus71gSdzNP68WeWMmOiP
         hvghsppaKOiaG53UPkR5Tr7qn4B0mDY8wgUSJ+Q+R7Z+CjPmNU5Y54n8yeHe35tS5r
         GhO6SdY0wvlzraR5KeD8wpteP7x9JFQ6JGCUE+ndSq6ytPfJoYXLctuYm2FLav7ElI
         GAIm9/Ex87Vrg==
Received: (nullmailer pid 1858098 invoked by uid 1000);
        Mon, 18 Sep 2023 22:29:39 -0000
Date:   Mon, 18 Sep 2023 17:29:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     John Watts <contact@jookia.org>
Cc:     dri-devel@lists.freedesktop.org, Jagan Teki <jagan@edgeble.ai>,
        devicetree@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC PATCH v2 9/9] dt-bindings: display: panel: add Fascontek
 FS035VG158 panel
Message-ID: <169507617909.1858058.4798985239779880637.robh@kernel.org>
References: <20230918125853.2249187-1-contact@jookia.org>
 <20230918125853.2249187-10-contact@jookia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918125853.2249187-10-contact@jookia.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Sep 2023 22:58:53 +1000, John Watts wrote:
> This is a small 3.5" 640x480 IPS LCD panel.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---
>  .../display/panel/fascontek,fs035vg158.yaml   | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/fascontek,fs035vg158.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

