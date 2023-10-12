Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F987C74D2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344173AbjJLRdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344075AbjJLRdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:33:43 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC7C185
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:33:41 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so2171417a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddatasolution-com.20230601.gappssmtp.com; s=20230601; t=1697132020; x=1697736820; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ogr/5eM7qfn+zrypn6phy/AwkbVCedzchxlSjrzZePI=;
        b=dPisb7E62/BABIJcDUsfxtI6TQWmXI5TNcBzT/lIEAFJ+LBH2UlptIfk+SG2qX2BLd
         EjyRModH/BumvVKTqGToryF18GpnuK0giAEiGb9g5DCzfTHQoB21os9kks87bNtBC2rl
         yTNZtBJLtZAhdXERGfoyI2UTmNipTGtdLDj4F77VJj8oNEg/OHQy+X90O/kOKoh56+vn
         5xGS7W8WU3NLSuxKFssuiz5+kHD00uHC3RnTmaTZIvlAvAeyD7tVjwEI66igtoJ7hDAu
         1t+VOSkoRbWQK2iA7tvymCryqSwCbAElQoqrnnMkZkpF9A5Hd3bT221ng17HlrKzcYJc
         9x5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697132020; x=1697736820;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogr/5eM7qfn+zrypn6phy/AwkbVCedzchxlSjrzZePI=;
        b=mLwZtO6UsOSCODVPSaQxYHy3kGSKNhSYCUT+r5ptyVwT9oQtVNPS5nRKtAop5lVYy2
         uy7KTpx+Kr7DOzYXRjMmBJAH9frDFTLeSWG6FxIwz8Uung6xqUHGDAvdFS8lNrBQtWmv
         umr8x1AtVdytCQyActwY2lAlZFMwsMjDQRNl1sPGfofV+NE/SAUBQpDziUvHZywlvyji
         fpHW73d2sms0n7nMBpzU4c7eNpwKkcDREmDngDkj16koJK8jwW2Po3VpbieHgGpSpkM+
         7bnb9baEssmi88mtuAUzBeDh1ikW4RH0jtt6Rugg/fNvk/TCKDMyZ/bQL4k8ndKH8oLR
         4zDg==
X-Gm-Message-State: AOJu0YzcOzc9rnPsCdJtdvmh8HWmqe+4liY9SNDvbyVObydgyN2Xln5g
        +14HYejRmgnL3BUosjlEGBXoZZ5812Yxf4SwBdxPEw==
X-Google-Smtp-Source: AGHT+IGOuQUla7LaNnj9O7gQyZDv512jLD9tm3a0tRDFFOzzCnzxmlyJuShSGJW/42MfmjVmtD/NsuE01WBpYzl2urI=
X-Received: by 2002:a05:6402:60e:b0:523:33eb:1103 with SMTP id
 n14-20020a056402060e00b0052333eb1103mr22554957edv.14.1697132020381; Thu, 12
 Oct 2023 10:33:40 -0700 (PDT)
MIME-Version: 1.0
From:   Anna Maria <anna@gooddatasolution.com>
Date:   Thu, 12 Oct 2023 12:33:28 -0500
Message-ID: <CAMfJWr52d_YtimuSa3+A3S-+mq9eNbimneyWg=gAC4wHix4hEg@mail.gmail.com>
Subject: RE: MJBizCon Attendees Email List- 2023
To:     Anna Maria <anna@gooddatasolution.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hope you and your family are safe!

Would you be interested in acquiring MJBizCon Conference Attendees
Data List-2023?

Each Contact Includes: - Org Name, First Name. Contact Job Title,
Verified Email Address, Website URL, Mailing Address, Phone Number,
Fax Number, Industry and many more=E2=80=A6

Number of Contacts: - 10,653
Cost: - $1,479

Appreciate your time and I look forward to hearing from you.

Kind Regards,
Anna

Marketing Coordinator
