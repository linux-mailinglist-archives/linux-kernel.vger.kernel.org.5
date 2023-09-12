Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C0C79CAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjILJCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjILJBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:01:50 -0400
Received: from out-226.mta1.migadu.com (out-226.mta1.migadu.com [95.215.58.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEBE10D0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:01:46 -0700 (PDT)
Date:   Tue, 12 Sep 2023 18:56:13 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694509304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AQMG4IAKejf/CGnCOSYDfecunXNntYUhuM2biZeDc8E=;
        b=yIZJ5OhdDceWTGU8MpBJJ9Lv0Ywhl3xSgMrkbjvJYrtXz99XD+m8oYp1m16KhKTEa9jqEn
        MPT8Sb0wpXVL7vcuK0ACtJcWUHtO+J5VW9B+8Gb+YvGTF22WCsAOb2z4ASaJK1WSgCOXXi
        1h4gF3MXZMiZlz5d4DxZp/LnWX+xkhU+DGtCAlHuwq1PwdTSBd7IRdO0BFKIsNLAJ4rLwF
        2lWVX9wM/+V5aizAkrhX+wziUms5n3bupy6kN9tTVleK1Uu7xO0YuXjzLFjbbuIOm0MhKH
        W/DabcmLaaYzuhosNQC/keG1e0VqPag4gF6pfVc5f/5HKJxcTTGWy6/xJhYA7Q==
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
Message-ID: <ZQAnrcYBfhLu-vbd@titan>
References: <20230911090206.3121440-1-contact@jookia.org>
 <20230911090206.3121440-9-contact@jookia.org>
 <e22e61e7-02b1-8127-888d-e470838f4a18@linaro.org>
 <ZP7il27e9cExVWaL@titan>
 <c4d89d97-f8d4-da2e-dea9-6c054cf07eb3@linaro.org>
 <ZP9Eoh06Sirl_97l@titan>
 <42d4878a-4574-377e-e307-0dbef2354aa9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42d4878a-4574-377e-e307-0dbef2354aa9@linaro.org>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 08:55:31AM +0200, Krzysztof Kozlowski wrote:
> On 11/09/2023 18:47, John Watts wrote:
> > On Mon, Sep 11, 2023 at 01:49:39PM +0200, Krzysztof Kozlowski wrote:
> >> If the other panel has exactly the same case, then yes, you can do like
> >> this. But it depends on the bindings - to which ones do you refer as
> >> your tmeplate?
> > 
> > Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml
> 
> The file is indeed serving as poor example.

I'm happy to fix it up according to your response and include it in v2 of the RFC.
Should this be split in to two RFCs- one for cleanup, one for the new panel?

> 
> Best regards,
> Krzysztof
> 

John.
