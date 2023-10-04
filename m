Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B087B772B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 06:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbjJDEia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 00:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjJDEi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 00:38:28 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE00AAD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 21:38:24 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id 006d021491bc7-57bb6b1f764so1083472eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 21:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696394304; x=1696999104; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEkw1KmmzfmMdZjy2G/k2kJ9Rp06l3CUoffIihDDUro=;
        b=aM4RgpOZ9jaok5PPURrnxoLzO52PMPj2rxCT7nXy8534YPlASNmtjKxFh7kfapspOs
         UwIKlT+kdVIjwnM+MFi3dIEjT6uzdsM3sS7T1i9IO36bUcilYUdDDlSXkFib7wuV7jA+
         MqPIEU/Oq3JBDnAcsMuB1aXmVVCax/YNtJqNoOpeTLCzp4i2PJfdAsnEfX2S7+6iMZOz
         ADJ54thgQfWOuN3rttwEVPV87LAKtLcjJGQo2WexQDoDGgENlagrEY7+xJEhyguIctD8
         Yt6b0wR6C1tKTM56lakzs/o+VsrWfuesdVkUfRMNA1P4hGEf+NazhYfaR7ALv832qPi9
         RpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696394304; x=1696999104;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEkw1KmmzfmMdZjy2G/k2kJ9Rp06l3CUoffIihDDUro=;
        b=Gy5jmf78Gd1GJ5Ar1sGhX1dxJ1ac9HeNTxJJaRCZDh43LqdLsM0QAZuHm6Hc/1K0w+
         4BfmHw8eREi1EsdiwoP3vgRA69+aR7AR+7Y0PcdG6mKC8GRHTqyD7qkSFPSR4lWug7tv
         24Fn/fcc4Vnkvw6FmUQvYhI1WLqEJNHNtU2t84HkJrSSbzeKkfhM5hGY4aotBfOhhTMr
         ciyvN3oilBHOIpQLNpJ+PCCmZUfKVsThzrEEd6+RVIA3a9zVw5+jY9zmfUrSNSK0405a
         Yd1w9FFhiyAaAQTCWh9Y0AouOGSMCVI+PNxigoFa8G0qbrWPgyETPps+7TlRPRKnWCwZ
         k9Xg==
X-Gm-Message-State: AOJu0Yx2weFZ41Qvq5PiitFpjsyyswobZjoqRY5WII5gInp47VvV2ywB
        +YgXnK7U4/T1wP4tV70CGHflovpXbCDHNXREYq0=
X-Google-Smtp-Source: AGHT+IGm/2JEqiE0/QY5Eg+yRU7DF4Rvf501YmbiZkubsI/IdEroDZ36x5LMTaZA3rHSbSlkAXnAoouGCICBHKWExpk=
X-Received: by 2002:a05:6358:938f:b0:139:5a46:ea7e with SMTP id
 h15-20020a056358938f00b001395a46ea7emr1196955rwb.28.1696394303874; Tue, 03
 Oct 2023 21:38:23 -0700 (PDT)
MIME-Version: 1.0
Sender: meizhen100@gmail.com
Received: by 2002:a05:6a10:b789:b0:4f9:6afd:7c3c with HTTP; Tue, 3 Oct 2023
 21:38:23 -0700 (PDT)
From:   Dr Ava Smith <avadrsmith1181@gmail.com>
Date:   Wed, 4 Oct 2023 04:38:23 +0000
X-Google-Sender-Auth: dRTeW-NviaW1u3olLG9_33LiWyQ
Message-ID: <CADYjMSTVNQj-Ui0AuxBC-sC1RG4gKUYPpVNgCR_m3j5z3zeZ1A@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
My name is Dr Ava Smith,a medical doctor from United States.I have
Dual citizenship which is English and French.I will share more details
about me as soon as i get a response from you.

Thanks
Ava
