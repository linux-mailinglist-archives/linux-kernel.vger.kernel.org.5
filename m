Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168A77A158B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjIOFlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjIOFlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:41:20 -0400
Received: from out-225.mta1.migadu.com (out-225.mta1.migadu.com [95.215.58.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C630E2709
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:41:12 -0700 (PDT)
Date:   Fri, 15 Sep 2023 15:39:49 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694756471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cCM3351WRdV6tVhq+BNSXK1D16VOR98tLWYlqsnRpDw=;
        b=u9eOnFw7G6nV8I4pyPcyYq5WTp+JJAn8sNstU2xz4zKQD9wNpeQPxcZ1wpS4NOu6dZGHPf
        qJgWrd3KczX9vFViCBZznRYceLqxrcfis/ccPHeucCwJX1BEeL5ffVWz3oNAMb4y6Kn7ab
        5J5J4XLFa7egL93YEc1z7G8xRQQjMziXepYYDPtgUn/Tk2K5Q+veeAYrALzbMk8ke03wFc
        22YaADVRIp2w6Qy6D3KyxGbWbwxbYCQkYcaBbVPnj5qm8Bb9TGr21SkPAKJLWg38ykDJpD
        QQXqBtr8brPT+rVOBC4wX6aQRllOlhRq+4XGqH6y+Kt0ZGhxn2eL8flZzrbR/Q==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Rob Herring <robh@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ASoC: dt-bindings: wlf,wm8782: Add wlf,fsampen
 property
Message-ID: <ZQPuJXcmHABQFaQl@titan>
References: <20230913171552.92252-1-contact@jookia.org>
 <20230913171552.92252-4-contact@jookia.org>
 <20230914145234.GA1275176-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914145234.GA1275176-robh@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 09:52:34AM -0500, Rob Herring wrote:
> What's the default if the property is not present?

0. Should I specify it here?

John.
