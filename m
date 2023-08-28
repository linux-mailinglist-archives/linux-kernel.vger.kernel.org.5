Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A3578B2E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjH1OWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjH1OV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:21:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92357C7;
        Mon, 28 Aug 2023 07:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27A8A61526;
        Mon, 28 Aug 2023 14:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A6EC433C8;
        Mon, 28 Aug 2023 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693232514;
        bh=r++i4l7dAyBt0Cv2DJDaKhmU+QSVVSZLLLtOXcGxmUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NzIhIe9GQ9X1nh4h53W0227E5B3Dk165E8Q7iUQbLkJYE32E1YSev1cjV+KZfzbX7
         9nB0qbGNhUxNjIqmVvZ0tEPMVUG+4mLm23tn4u/m+eY6hl29HcrIqt7luFxWs78yGo
         QU3+7PKtW2Q14YG33c1pzfTeJqNscZfNEs2fcA2MIQdmYulyw3WF7UNKDPkVu/uGIp
         +JAQu2JDJrGN15YnNEC5fXr+ttXhQuOFrD64BO7h7qyD6Hsy+dUfUOt7JFEshCYQ7a
         JhATzRLgWceeUxN+rccD2bs8VolOm/wfLh/faKWcuo3kTfdoJ5k/FtSdich4+2zF1F
         /YPCeTuN9m+yw==
Received: (nullmailer pid 433193 invoked by uid 1000);
        Mon, 28 Aug 2023 14:21:51 -0000
Date:   Mon, 28 Aug 2023 09:21:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amitk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: thermal: lmh: update maintainer address
Message-ID: <169323250890.433087.13210880299716827951.robh@kernel.org>
References: <20230823223622.91789-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823223622.91789-1-david@ixit.cz>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Aug 2023 00:36:22 +0200, David Heidelberg wrote:
> The old email is no longer functioning.
> 
> Fixes: 17b1362d4919 ("MAINTAINERS: Update email address")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

