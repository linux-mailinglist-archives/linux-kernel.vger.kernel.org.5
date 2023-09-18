Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735A57A55CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 00:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjIRW2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 18:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRW2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:28:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D9D8F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:28:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A65C433C7;
        Mon, 18 Sep 2023 22:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695076109;
        bh=Cm6gdHRXbYq+GvZmRva1a3/Sze3/iw5r/rmeAg1FI2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OiPlyidCV3PVOmISTNABR9087gxEv8kvpZbkwolzYvgnWPBPGl0KnVkScS1Qgbkwc
         2di8LxHcimqri0koEQ7zsjF/e6BXUOkINpHYBhoW+RSjNJIJ+lMFSolVk9O/yoTBmn
         RIg8PF7+Xg33wNkN00a3n8OQi8F0vkg8uUOEZY+3bFM+jYrkLQCIM6JGrbIs8RB569
         U0yRn85/zwSXUwQqetEjSbvQOE7SYgeZhhR/S+HgiVmhqmyn46C1i/6efWHW0jGivt
         RYklZjuwZgInLmkVHWEU+X02Dree3YZlaVrd4VIYgm+eZaLJ17nMF6qaEJrHQ3Cclq
         VBaKzNEzb7l4Q==
Received: (nullmailer pid 1856606 invoked by uid 1000);
        Mon, 18 Sep 2023 22:28:26 -0000
Date:   Mon, 18 Sep 2023 17:28:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     John Watts <contact@jookia.org>
Cc:     Chris Morgan <macromorgan@hotmail.com>,
        David Airlie <airlied@gmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Rob Herring <robh+dt@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC PATCH v2 7/9] dt-bindings: display: panel: Clean up
 leadtek,ltk035c5444t properties
Message-ID: <169507610587.1856550.8091958935688458267.robh@kernel.org>
References: <20230918125853.2249187-1-contact@jookia.org>
 <20230918125853.2249187-8-contact@jookia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918125853.2249187-8-contact@jookia.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Sep 2023 22:58:51 +1000, John Watts wrote:
> Remove common properties listed in common yaml files.
> Add required properties needed to describe the panel.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---
>  .../bindings/display/panel/leadtek,ltk035c5444t.yaml      | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

