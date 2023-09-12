Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7870379D20C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjILN0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjILN02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:26:28 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2212B10D0;
        Tue, 12 Sep 2023 06:26:24 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 78431D5D;
        Tue, 12 Sep 2023 15:26:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1694525182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jQgKxqQjeOM97imnHnc/zUUbAeE3tSPt0RmaOqIa4zA=;
        b=A10eRIHT69dvqIxmFtN2n5ajpNs9qOvBvCLtz68KKmY5Mwynoi3hz5bz+WbYMo3KtU2+tk
        D2AwHhueYubYva2KsR5+0B646VeXCV702zBUPvCR/wldkrkZkj43HRaPpK6F6i9lo9gDCe
        wZZEA0oxo9LU1ZyLCOXfxo8+q/pQVxdzQPO4bojOsSaVv0gFD72PsvZc8Fk27tggTzJqCv
        1QUiimwCpqnSSyfsZf8uvARoykCfVBu3RLlimrKov0+PepYOzxpY3KVPFLTHx3FfSArrmk
        BGnXgPG8Q9cRt3NxxuZIK0wS8MClyIu67pqCA1wV9go46IljBGWHEr2eLp9yIA==
MIME-Version: 1.0
Date:   Tue, 12 Sep 2023 15:26:22 +0200
From:   Michael Walle <michael@walle.cc>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: gpio-regmap: make myself a maintainer of it
In-Reply-To: <CAMRc=Mcj77F7SZ6BxDimnD=2iXe-g02yG9KuFCKTj0m58SzOTg@mail.gmail.com>
References: <20230912122850.164150-1-michael@walle.cc>
 <CAMRc=Mcj77F7SZ6BxDimnD=2iXe-g02yG9KuFCKTj0m58SzOTg@mail.gmail.com>
Message-ID: <0dc01be91d0958db93937d1628477b61@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> When I've upstreamed the gpio-regmap driver, I didn't have that much
>> experience with kernel maintenance, so I've just added myself as a
>> reviewer. I've gained quite some experience, so I'd like to step up
>> as a maintainer for it.
>> 
> 
> Do you think about maintaining your own tree and sending PRs to me?
> I'm wondering if - given the little volume of changes to gpio-regmap -
> this wouldn't be unnecessary churn? I normally wait for you to Ack any
> changes to gpio-regmap code and drivers based on it anyway. Otherwise
> if it's just the formal role of the maintainer you're suggesting, then
> sure, I'm all for it.

No, no own tree, that's overkill ;) As you said, it's just some formal
change.

-michael
