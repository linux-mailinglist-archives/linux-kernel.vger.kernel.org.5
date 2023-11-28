Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7257FC37A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346453AbjK1Sha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjK1Sh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:37:28 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1212E1AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:37:35 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d81faeefc4so1755195a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=healthydataprovider.com; s=google; t=1701196654; x=1701801454; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLei1y44F2b3kz8WHi7xOT7oMK6bh/F7H/Cr3/KHrHI=;
        b=RRbpY3qnlVJexYio6X2EgEna2fJ1hPOZnUsfgASdI1J5rWqHc/BP0J+sJWpmr8OnrH
         XkPtbjbGvo9HwvYfi4U4qjuzaX/rsVV7O82AMTmyK5K5DQ9XI2VluYenM9nHwoeMQs2c
         sKWasACQBKfopLveAnvtHINEgAR+zAdDFmYcHqErl0bQBODC3VFkFeVDMw6KT63GsH7+
         pZ3778n1sg130BBLAzGNSppcA/Ut/OXsUpD1uKtZpzulpL15ZBpR0qenuUZ1/xa1fkX3
         +3KjKRcvREud30vhieD2oBvBaemtwds0K/4wGXZf4GlUiVgF/96b+NFdxcc94j8iqN2H
         OC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701196654; x=1701801454;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLei1y44F2b3kz8WHi7xOT7oMK6bh/F7H/Cr3/KHrHI=;
        b=doXNozKiKSFKlVzFx3bVhjQUVGMWQELP/Y40pq8QJSsur75dbBymnCa5dkbu7ifWJJ
         Lft1P+5bc6sSoBBLbfJiQVdnfN07YfTgQSqx7J0QR3KwHLxhrR4vJaPVexkW8CBvmtbt
         evzyN9f2tQBEJ1IgmykQuT0FGroIizzS5a2TNsUP58Lvty4/ra7WY+91IKOAOLSOnY8l
         40MpBr9WwaJLBqqAWJ2w3W9pe8ejroPf35LUsxcBViXwC6tQ2ifmE8Zfv13JJ+xfu5TV
         CA+lTHUBK/tonhq310aGf3UpLESWfHDC83bnCfAEHKELwOzcFj1l7L2Ym7c5FWTUJ29o
         7VZA==
X-Gm-Message-State: AOJu0YygX+ByGPNufI6e17c1g9fL3niw/hbAyPQmHOtM8whpcChm8upY
        HxgQAL1Kxq3nVkA9kSqxZizyhA7wvHf+Cp7TUdm82Q==
X-Google-Smtp-Source: AGHT+IFEoerYIO8qGDRyR2Swe5CU8nijS3nYNZhL1/99uT/823HbirqoxNSXsTZdR6TJAylrjPGfHNscbFW6mbEdX3U=
X-Received: by 2002:a05:6871:460b:b0:1fa:3e11:7104 with SMTP id
 nf11-20020a056871460b00b001fa3e117104mr12197325oab.6.1701196654427; Tue, 28
 Nov 2023 10:37:34 -0800 (PST)
MIME-Version: 1.0
References: <CAEBxSDzim+_W+4PkQVH4sk7thgHu1atoUek0beWcd6=bhH4qqA@mail.gmail.com>
In-Reply-To: <CAEBxSDzim+_W+4PkQVH4sk7thgHu1atoUek0beWcd6=bhH4qqA@mail.gmail.com>
From:   Rose Frank <rose@healthydataprovider.com>
Date:   Tue, 28 Nov 2023 12:37:23 -0600
Message-ID: <CAEBxSDxF-Pm_Xm_eBx4XmpTnnGD3JU347hWa3vSdV7CC+W0Sjw@mail.gmail.com>
Subject: Re: AWS re:Invent Registrants Email List 2023
To:     Rose Frank <rose@healthydataprovider.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Did you get a chance to review my email?

Please let me know if you require any further information to take this
forward/make progress here.

I look forward to hearing back from you soon.

Regards,
Rose Frank

On Fri, 17 Nov 2023 at 14:21, Rose Frank <rose@healthydataprovider.com> wrote:
>
> Hi,
>
> Would you be interested in acquiring the AWS re:Invent Email List?
>
> Number of Contacts: 42,486
> Cost: $1,918
>
> Interested? Email me back; I would love to provide more information on the list.
>
> Kind Regards,
> Rose Frank
> Marketing Coordinator
