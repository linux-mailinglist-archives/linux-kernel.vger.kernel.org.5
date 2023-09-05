Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFD0792F96
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242887AbjIEUI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242589AbjIEUIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:08:41 -0400
X-Greylist: delayed 3539 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:08:37 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE05CC;
        Tue,  5 Sep 2023 13:08:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F09C433AD;
        Tue,  5 Sep 2023 18:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693937829;
        bh=eJvviLwDFqy9JoGB1FIfd4zECgh9rL9Utbsa8UqT9zY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fWwkGOTBJiXRrUmLSjDfge8NnrrB0ljH9O1BcNAaSq6UvaLq1Q9iJCtD7/Zu2YJKn
         /sbbh+VoiLiw63Me9M41FT63ozxHfQYWNvdrsglus5eyMAs5fCnbYEa12CbuaBJHMQ
         GDeAmfL8QhBDGDYwV3gMCknPixQTviyPlYDY8IntXOr+JCqK5r+MOwBCU2IGSW31ya
         /7oG9Ihc4pxRhed4JqBY5v0ZKJq9FLz1N7i65IpF5HHxk1FVHg4J4s6805cSkZta8M
         rIJq8gDxMNsNRS/An5jGIQ30SBbmU0jeQca0YfduiWw8+inWLgKHJM8AH7+K+UB3fT
         DdwJ297tVhvzw==
Received: (nullmailer pid 3744523 invoked by uid 1000);
        Tue, 05 Sep 2023 18:17:07 -0000
Date:   Tue, 5 Sep 2023 13:17:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, vkoul@kernel.org,
        quic_wcheng@quicinc.com, kernel@quicinc.com, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        abel.vesa@linaro.org, kishon@kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: usb: qcom,dwc3: Fix SDX65 clocks
Message-ID: <169393782673.3744474.2406769381713215825.robh@kernel.org>
References: <1693909838-6682-1-git-send-email-quic_rohiagar@quicinc.com>
 <1693909838-6682-4-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1693909838-6682-4-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 05 Sep 2023 16:00:36 +0530, Rohit Agarwal wrote:
> SDX65 has 5 clocks so mention in the bindings.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

