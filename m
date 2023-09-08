Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC47990E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343732AbjIHUQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242765AbjIHUQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:16:20 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817F38E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:16:16 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-56a9c951aaaso1863854a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694204176; x=1694808976; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=idTHmGbjvwMxFcySx0P1DwMXpzVW3OThojzbPWRR7+o=;
        b=RXUn3mbURe1Ywj+ZArDaBRsR1S5aABmyf3HbUVrkeX/TrUmV4Bz2Z0rPDdgyowIfEF
         vWjZp4tTjgiZpmyamIMI2EAWdA5xYLU/10NfjcXZk0H2V/h1m62YYzLzuorzymlM/Cpc
         pjF4yjZgL35vBLM2RB32yVyGt4doYO1EjHsILvfx9ZgTZUjZmBfxPXfQ5vWdYEijBtyv
         7onLAwQ8fflbj24RoFBCAiBHlGPKQNJ9UgotzE7SOHhXHuvjVyPnPTeuUuSuBILkGALD
         FpLzlbAzNGt5sRKEd8T/cdDa86arkNYhIjEEDlqu/zWlJ/B38p7E53K1AYsCmf6WpYE8
         ayEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694204176; x=1694808976;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=idTHmGbjvwMxFcySx0P1DwMXpzVW3OThojzbPWRR7+o=;
        b=jX44XbDoWSVcuvRfMKKuP2l07/iYEOtT3hRMoequGPZRrD0UuHa8T8AFoK266W6oCH
         UkGRb4507FRoshmlt3KGEK8VKjsuZ4TrANcoTpNk4xhNfWbpT99Ly+M/JN6mq+1mkDPi
         vfOUvv0cYDmaYU/1+69KG2GS7Mm+2ysRN+NJRPqIfu2yhEyKqsMim3zN/+x1ixmUZ/EL
         QO9m9byv4PbAGBM/zvP+nv2l0ZR3fh86RN/KHcgUghvUuD6K5VxqFAlN66Q61atn8lqm
         AJuyCyMqp3pqI5c4s/Rgw6fxH61cuveRBpcMmXUJvl6BnSjbVDBMsT1sQ8A1DR0VNxGd
         qwuw==
X-Gm-Message-State: AOJu0YyESHWWkrSwQNqMQ9Ub5PBRnR9Aph/TZabJJWns2ipb17nkFGjP
        MSOZ/OWFetT60SsSSqoqwfhT/mO5LBuI5im2dw==
X-Google-Smtp-Source: AGHT+IG6b44G5VQBbWW1jeUL3OSiZ431Sq/TApu51ll8x/zpqXRf/8RHWG7bpJQqo+FUivoPe5p5glTsK7muYJcbY/s=
X-Received: by 2002:a17:90a:d482:b0:268:5203:b8b7 with SMTP id
 s2-20020a17090ad48200b002685203b8b7mr3755310pju.21.1694204175884; Fri, 08 Sep
 2023 13:16:15 -0700 (PDT)
MIME-Version: 1.0
From:   Amanda Jack <bestmarketb2bdata@gmail.com>
Date:   Fri, 8 Sep 2023 15:16:04 -0500
Message-ID: <CANQ-A3PBo2frNo9E49bgU9OHJGh28qZXaaVP2tmUHHG4ba06WA@mail.gmail.com>
Subject: RE: Dreamforce Attendees Databank-2023
To:     Amanda Jack <bestmarketb2bdata@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you be interested in acquiring Dreamforce Attendees Data List 2023?

List contains: Company Name, Contact Name, First Name, Middle Name,
Last Name, Title, Address, Street, City, Zip code, State, Country,
Telephone, Email address and more,

No of Contacts: - 40,438
Cost: $1,926

Kind Regards,
Amanda Jack
Marketing Coordinator
