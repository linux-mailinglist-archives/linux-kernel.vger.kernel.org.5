Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7CF7B87BB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243859AbjJDSIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbjJDSIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:08:41 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92174A7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:08:37 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-692c70bc440so53410b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 11:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696442917; x=1697047717;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9iYrjHOyfOKIUcVEs2UDJbgeqtyssNJDxi1mGLZrX4=;
        b=BkOmNueXm3Fr3BQtnxS+5sJTV5rArfnjPuZJvm/pEIk5t0Exdp8p3de4iY/q5+L773
         VDumbvB0/RzY6NM4phPMcT0+oSHvAFv029TGl6a+mvqyWdPSHwKaMawmNul2ZfuPXVhA
         VXZPN9myhrnz0QvWEvAUdvNAhg1m/cnDgqIF4PvBN5mJ33D8qPl3bntgg3NefW6q7esM
         sW74k6/viz4kO2k04Pd+nfngrWMWmS0iszYp8DgLjBykdup6wFNSpe/vSH+b7ZiEydJ1
         9v8Mc56xOTRXzQTwByGSTnxzDd0jm4JfFkcuK3vcXNnt/GxkY3W1vtaesikRqXA9HTRY
         6MPw==
X-Gm-Message-State: AOJu0YyLIkYaDjy9emTTgdc+jQby7uWfB/CW0U4Lfv7RIKCuF1eq1Tux
        XWPKQCO+hhmsvPoaG5RA7WSS6A==
X-Google-Smtp-Source: AGHT+IGChQBN+ORe86zQsRfP8sgNZXca4nlpKZuqOVrZVMZJgmrdlPzT30mCpFbTG7lG/oc9xpYLPQ==
X-Received: by 2002:a05:6a20:431c:b0:136:ea0e:d23 with SMTP id h28-20020a056a20431c00b00136ea0e0d23mr3578146pzk.11.1696442917014;
        Wed, 04 Oct 2023 11:08:37 -0700 (PDT)
Received: from localhost (71-212-56-62.tukw.qwest.net. [71.212.56.62])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ea8200b001c62d63b817sm4016430plb.179.2023.10.04.11.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 11:08:36 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     nfraprado@collabora.com, wenst@chromium.org,
        matthias.bgg@gmail.com, robh@kernel.org, amergnat@baylibre.com,
        arnd@arndb.de,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] MAINTAINERS: Add Angelo as MediaTek SoC co-maintainer
In-Reply-To: <20230929082009.71843-1-angelogioacchino.delregno@collabora.com>
References: <20230929082009.71843-1-angelogioacchino.delregno@collabora.com>
Date:   Wed, 04 Oct 2023 11:08:36 -0700
Message-ID: <7h8r8i5kgr.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> writes:

> I am a top reviewer mainly for MediaTek SoC related patches in most
> subsystems and I've also been upstreaming both improvements, fixes
> and new drivers and devicetrees when required.
>
> The MediaTek scene saw a generous increase in number of patches that
> are sent to the lists every week, increasing the amount of required
> efforts to maintain the MTK bits overall, and we will possibly see
> even more of that.
>
> For this reason, and also because of suggestions and encouragement
> coming from the community, I'm stepping up to be a co-maintainer of
> MediaTek SoCs support.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

Thank you Matthias for all the work you've put in over the years to
maintain MTK SoCs, and thank you to Angelo for stepping up to help as
the volume of maintainer work is increasing.

Kevin
