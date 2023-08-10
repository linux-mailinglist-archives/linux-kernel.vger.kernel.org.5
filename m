Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994787770B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjHJGuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjHJGuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:50:08 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1571AE69
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:50:08 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-56dd683e9b3so257149eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 23:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691650207; x=1692255007;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+azqYrvJoMRfxtRmCqDGPskykls87vfsK+SguMOfco=;
        b=ArbCyZCkLsaeS8ObeFvhwfaaSQmJyM3e7kZOm2s7ug23gpRgh5DgdE0J0S17QwsJ3o
         yLN33OZjYQ4b24F8vYOAfG3ebhx8VuK29k8LbHixfNKXfofAyoR3mQYeVfbh61vZSk8p
         2LHutQwozaELxxXjl/7Eqb7RgOgLFHl9yIDrVOTGFrX/65k9tdeZG5l4agzzXDbE0GC2
         3cGT50CqaLUK6RYx28i4nwho+AtKkERQYL9afzEO5Z9qEpNXrkmkLsqjo0gx8WOpcHjv
         32jLowODTrLy4O13rd9cOEAtNIUfzYCeDATWscwmJNgHJbDON17wHZt7OtCFGxk60ZpX
         X9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691650207; x=1692255007;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+azqYrvJoMRfxtRmCqDGPskykls87vfsK+SguMOfco=;
        b=U0ttViYpRTmwDYLMqQNS9gyK6I5icKX8ZhQL7D5uAA+HaCe2TZLG2927TXwZbI7XCY
         k5ufs2LJd8YuGidpz4NV5vDWV072IUHA/MbbuAIznp4so+hM0oV+fxrWdhpcH3fB8UTV
         m8LvHM8jkG0k9hYlaJYX22grLcVBoh98DmtsGPaYGfPJ2SzDsdbkmUOcBaeuo8z6Esgo
         Tks8cfxuN6qh6Knh4a0LHMIUWBiFBJO+icrJDBxM6IK3m7yIqIlSgyeNdvhpaRUzXoRM
         yAfj80qKZpyxJpmXYbAB0ogQusj2ncmGLQSsNDVpOwkTiPCm/7dr92hrooJpynMHfjnX
         I6lg==
X-Gm-Message-State: AOJu0Yx959FiVJCEu47fhfW+q+ND9744KsoF70SWptpI71kGjOofiZhl
        Nq1zBgAYi/wV65dp+Amt9Tbwp3FwSUX8gYT8AVYL54KW
X-Google-Smtp-Source: AGHT+IHBF0MkpN+h3rE1QS6YOX7Lpoq3wZNiBPoYTay0hoxb22JQlSRrT+ML5wcoPfCiXmgU1Btx01kE/OFBlfXegkI=
X-Received: by 2002:a05:6808:1982:b0:3a3:e638:78d2 with SMTP id
 bj2-20020a056808198200b003a3e63878d2mr1910193oib.12.1691650207235; Wed, 09
 Aug 2023 23:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAOXzkJpQMkU1O7oSWttegi2r3t8w4rTmtYDwCqdObupreEvUtA@mail.gmail.com>
In-Reply-To: <CAOXzkJpQMkU1O7oSWttegi2r3t8w4rTmtYDwCqdObupreEvUtA@mail.gmail.com>
From:   Luna Jernberg <droidbittin@gmail.com>
Date:   Thu, 10 Aug 2023 08:49:54 +0200
Message-ID: <CADo9pHgwYsQuyBrnkh6=cQkjbbtCMK=6QOMyZix1jJZtz8GjKQ@mail.gmail.com>
Subject: Re: Hello
To:     davidbenjamn2022@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luna Jernberg <droidbittin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems this email got sent atleast

Den tors 10 aug. 2023 kl 00:26 skrev davidbenjamn <akokon27@gmail.com>:
>
> Every time I retest your email, it tells me to check with my ISP or
> Log onto incoming mail server (POP3): Your e-mail server rejected .
> Kindly verify if your email is still valid for us to talk.
