Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6541880073D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378096AbjLAJiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378034AbjLAJiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:38:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4558C12B;
        Fri,  1 Dec 2023 01:38:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3238C433C8;
        Fri,  1 Dec 2023 09:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701423491;
        bh=1sFqvuT/UoI9Gn2AZFl8jIGRwWG68Rvg+NmKuILk70I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jN+EBoBwdHQdiTvQDMX0gerZBPBH50mhnEQwVe2XJ77WHzpLpMcn5P9BdKJ332EH4
         Z385f7rliDEUxgEctLD7+DTSHcsKTSvKMSPUavE0QnNTklojJR4LReKTm1OKY5cF/N
         MGPWeQyYo65+sCUA4MwoO5meq9WONi4G1UV1HjNkYUMS0amEGp3U+GEzPDEIJgcHdz
         FThp/tXh0g7KwK4SKICT4hntJzSqLVxD/XabCLghTl3GTvQq3f+ZjykcJCdJ8a90An
         2CbM6jPQVZU+FLr/QWNJ3dHuAlmj8K4BfZt0c4bEM2065ioI+UI/RIHyu7qTdC5fKs
         a3avuVVtqVXwA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r8zyx-0003Hq-0d;
        Fri, 01 Dec 2023 10:38:47 +0100
Date:   Fri, 1 Dec 2023 10:38:47 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        inux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: qcom,spmi-flash-led: fix example node
 name
Message-ID: <ZWmpp4Va5Xn1iC6J@hovoldconsulting.com>
References: <20231130171940.12391-1-johan+linaro@kernel.org>
 <eddf541d-e505-457f-9363-f5e96885ee25@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eddf541d-e505-457f-9363-f5e96885ee25@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 09:42:02AM +0100, Krzysztof Kozlowski wrote:
> On 30/11/2023 18:19, Johan Hovold wrote:
> > The led controller is a child of an SPMI PMIC, which in turn sits on an
> > SPMI bus.
> > 
> > While at it, add some newline separators to improve readability.
> > 
> > Fixes: 1aeff6216891 ("dt-bindings: leds: Add QCOM flash LED controller")
> 
> Nothing to fix here, just an example code.

I'll just refer to my reply here for completeness:

	https://lore.kernel.org/all/ZWmn6uicNIqqSwoE@hovoldconsulting.com/

Johan
