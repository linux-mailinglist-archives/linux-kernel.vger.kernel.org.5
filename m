Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F6F7BFEDC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjJJOPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjJJOPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:15:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5A191;
        Tue, 10 Oct 2023 07:15:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660F7C433C8;
        Tue, 10 Oct 2023 14:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696947312;
        bh=H2yPB100sW/jX4e+ju+J0zwg4FdmUd9E3jx3UW+wroE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u2fb2COr02JrH4UgNP7DRPsoSDT1ntX9Bk6DH2OswZDmAWe/VOb24qW0Ec/3M2YzX
         rVUX9+BR9F87JOvI3Eaku+jskgcv5Ci3RI2+uQ1VXtewrIlGh+mbBAPiFmYF5K384w
         yOBS3PczC+j7AJOSkzLYRKOYGn2HrVIhjImL8kOjjRT/TiD4vqq5Dwt/327hCtqSgu
         V+zfOG2qZuxEweJk+qb2DRA0JWdm0mJfLA9xgg7U0cAbddjPG6ULMP4IuvRenp2ssr
         wXdBcRJAOQHoXR2s675qGF80fAVCSL8F/uLn23qgvIhBgLdGvFxk8fuv0O1U0mRpT6
         ww41aGLhnMbDQ==
Received: (nullmailer pid 779608 invoked by uid 1000);
        Tue, 10 Oct 2023 14:15:10 -0000
Date:   Tue, 10 Oct 2023 09:15:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     andy.shevchenko@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee@kernel.org, George Stark <gnstark@salutedevices.com>,
        rockosov@gmail.com, pavel@ucw.cz, conor+dt@kernel.org,
        kernel@sberdevices.ru, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v1 06/11] dt-bindings: leds: aw200xx: remove property
 "awinic,display-rows"
Message-ID: <169694730940.779396.17395041529564271514.robh@kernel.org>
References: <20231006160437.15627-1-ddrokosov@salutedevices.com>
 <20231006160437.15627-7-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006160437.15627-7-ddrokosov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 06 Oct 2023 19:04:32 +0300, Dmitry Rokosov wrote:
> From: George Stark <gnstark@salutedevices.com>
> 
> Get rid of the property "awinic,display-rows" and calculate it
> in the driver using led definition nodes.
> 
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  .../bindings/leds/awinic,aw200xx.yaml         | 28 +++----------------
>  1 file changed, 4 insertions(+), 24 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

