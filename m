Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612DD79B0D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348773AbjIKVa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243121AbjIKQvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:51:46 -0400
Received: from out-227.mta0.migadu.com (out-227.mta0.migadu.com [91.218.175.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F32F110
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:51:37 -0700 (PDT)
Date:   Tue, 12 Sep 2023 02:47:30 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694451095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NJBFtilo+N7MwmK+qDpVaOWLYzmxlK73lqWxMLheTIo=;
        b=GriUB6QXaNVJraMfYdO0IAoT9YfQyYJZU4vJ0jmLhfLPYQEgcb9DBLLy8UvxVGtx+k70HO
        AhkiLR2s6cwBbAhR5TqmWDBiiQE959BG4CuRdScGXXiaGWWrRujExTMo9Kn8pla9u7LxKq
        bVXxuy7nJZpQzOxRB+UZl9YqrInmc0HQbyCcyGDvl9CcXV7/lPqoUmiHUKVifLfCit/iwl
        z/vdc58PjGGvHNNmyegZW4QGLdOCegI2yKghHQ7wMuSfm1XrccZv2q1eW05BKvy3b/SUO5
        2P+XZGpMvWSX8a5TPY3dqnM8F8rQ68f2Vv3VhmGhe8o6Kq54uD1PkL+MqTU9Fw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 8/8] dt-bindings: display: panel: add Fascontek
 FS035VG158 panel
Message-ID: <ZP9Eoh06Sirl_97l@titan>
References: <20230911090206.3121440-1-contact@jookia.org>
 <20230911090206.3121440-9-contact@jookia.org>
 <e22e61e7-02b1-8127-888d-e470838f4a18@linaro.org>
 <ZP7il27e9cExVWaL@titan>
 <c4d89d97-f8d4-da2e-dea9-6c054cf07eb3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4d89d97-f8d4-da2e-dea9-6c054cf07eb3@linaro.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 01:49:39PM +0200, Krzysztof Kozlowski wrote:
> If the other panel has exactly the same case, then yes, you can do like
> this. But it depends on the bindings - to which ones do you refer as
> your tmeplate?

Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml

> 
> Best regards,
> Krzysztof

John.
