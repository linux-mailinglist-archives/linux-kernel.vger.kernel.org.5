Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A4F794400
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbjIFT4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240806AbjIFT4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:56:05 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4DA95
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 12:56:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5924b2aac52so2548037b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 12:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694030161; x=1694634961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Op44xSZ18T8lyHwRCrYU4O2AD6VMTohVe5tEwcZQ8PA=;
        b=Zj01IHhRpMb54nSiAFiV2XFNau9q3QVhxr6qq2Z7O8aauullFtg12IT9qJ4DQ0EP0K
         //F+CSzIm4eFcejdZMLjLc+C+ZB8jORSn6jOYMilI1PF/S0RGrnkvnjRmF8+VfDau/cc
         NZzRPGizPjozqvQeJAdbyTodqj4R19y7XKXBtqBabVkHhAkm1cMtdWOYahsT2JCLM4Gf
         QHX3m3ES3VgyAm6VqgyEiRpzb62jJbS7XQlWsJOrqDZ+0WVikB0ZNu8yuQi/Ll9wDNcJ
         Kf8DX+dcUW/knoO3+1hsUyawL9tNlb+Zyh77HO7MbrqplKfFgj0xXZckYhY3mhcFYsVF
         TbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694030161; x=1694634961;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Op44xSZ18T8lyHwRCrYU4O2AD6VMTohVe5tEwcZQ8PA=;
        b=TZtqlkDH/3rYcNjKTO7T37bNea/qMhXTqa0Wxdeg5k53aRxAHbsmQO1xsTnlIkDkcr
         i6TXuiw/4Fd5bPDFAc+iGI3/V+hFmNTcJc1ex0DSgUvgyhBA5taFLfoS0tTwZXL5HjKD
         nDtU55FpbeYYXFuPR2zNWboIouwmgP8qQuMiBPA0TMYvCMgiFc80f1WiEO282lzaWiQo
         XuHV1cPxt3azq7MOsAVmLVatWtVr15YjQCvz1gUZAr4K1fS3v0K9AXIEupFLL2RghBTu
         PTpjZS4Os8vZUkPnPWZ4J0B86t0v+0aMT/hpL7MX5BhfEV7+IX26pNfBB1uo9mKut9tH
         se9A==
X-Gm-Message-State: AOJu0YwrVUU8g5haleLpM/XLVr2C4TtaKYxpShW2dauEWTZlvOet4FhO
        71XCMNsZIaAkYT8BxylU72FHpu/a7Fc=
X-Google-Smtp-Source: AGHT+IElmezyAZuhMQzTl/Sk7vPNTCNoUPzlYa2syrQ7BTn8+o6eKVIx89oi4Cuo7O2wkISUyMw/EFo9ef0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:e40b:0:b0:592:8069:540a with SMTP id
 r11-20020a81e40b000000b005928069540amr420956ywl.8.1694030161662; Wed, 06 Sep
 2023 12:56:01 -0700 (PDT)
Date:   Wed, 6 Sep 2023 19:56:00 +0000
Mime-Version: 1.0
Message-ID: <ZPjZUE2qmXhb7So8@google.com>
Subject: [ANNOUNCE] KVM LPC Microconference Call for Abstracts closing on
 Friday, September 8th
From:   Sean Christopherson <seanjc@google.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call for abstracts for the KVM Microconference will "officially" close this
Friday, September 8th.  We will review submissions next week and publish the
schedule no later than September 15th.
 
Apologies for the short notice, I was originally thinking we'd wait to publish
the schedule until October 1st, but we ultimately decided to go with September 15th
to give everyone more time to prepare, book travel, etc.

Thanks!
