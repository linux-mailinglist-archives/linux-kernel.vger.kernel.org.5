Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B951379D7F8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbjILRvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbjILRvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:51:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727D810D3;
        Tue, 12 Sep 2023 10:50:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4417C433C8;
        Tue, 12 Sep 2023 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694541056;
        bh=RMkwY8/Jmn0reBNJqxSzXAz0X4xlHTx/4N3xlZ/F8mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ob0bq6N++LzLd3a3B8YX+FxFaukN+zywJ+VP2Qj2OIsVyJqNWeNy5YCUw6cv9cPt5
         IzokpDNJjx4IH1ezTBCzawMksutA93LUs/Vlc9WPdovMNMXCAgktwTyGqUM1V3uwQg
         C61MB3roaoXN7I51XEieYl1r9aqEYw3/7Sta32AvISxJrH9Geb8MRoaLqe5q+GvW87
         LUAxIrJkrrTy7lyDxFw0NrWgtTt/udL+xFqunJDPP/e+74gVOcll3yNm82jFtIEYIq
         bqn7NLxETj4Z7mNWeNnAh/YnDo8L7gKpIV2/6GVxHGLxFcDF2JrGw71fchD1mOZscQ
         YhU4Xu+boyGMw==
Received: (nullmailer pid 989278 invoked by uid 1000);
        Tue, 12 Sep 2023 17:50:52 -0000
Date:   Tue, 12 Sep 2023 12:50:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     wangweidong.a@awinic.com
Cc:     fido_max@inbox.ru, shumingf@realtek.com, conor+dt@kernel.org,
        lgirdwood@gmail.com, harshit.m.mogalapalli@oracle.com,
        colin.i.king@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        rf@opensource.cirrus.com, sebastian.reichel@collabora.com,
        perex@perex.cz, devicetree@vger.kernel.org,
        ckeepax@opensource.cirrus.com, ryans.lee@analog.com,
        alsa-devel@alsa-project.org, yijiangtao@awinic.com,
        linus.walleij@linaro.org, povik+lin@cutebit.org,
        broonie@kernel.org, trix@redhat.com, 13916275206@139.com,
        robh+dt@kernel.org, arnd@arndb.de, liweilei@awinic.com,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        herve.codina@bootlin.com
Subject: Re: [PATCH V2 2/5] ASoC: dt-bindings: Add schema for "awinic,aw87390"
Message-ID: <169454105220.989223.11380919348006070430.robh@kernel.org>
References: <20230912065852.347000-1-wangweidong.a@awinic.com>
 <20230912065852.347000-3-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912065852.347000-3-wangweidong.a@awinic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Sep 2023 14:58:49 +0800, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Add a DT schema for describing awinic aw87390 audio amplifiers.
> They are controlled using I2C.
> 
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
> ---
>  .../bindings/sound/awinic,aw87390.yaml        | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw87390.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

