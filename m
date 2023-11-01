Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F109F7DDED5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjKAJ6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKAJ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:58:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1C7102
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:58:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so11251348a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 02:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student.uny.ac.id; s=google; t=1698832708; x=1699437508; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U3pfk9cqqe8i+/+fOTb1lE6xWp6G+mo2TybLpvLQN5I=;
        b=H3DVfF+wEgV1lWvS0EmtO8f5xlMAxXU8vU6p7DsVE1TjR7nsfBm/pWX20uAVHM7LdH
         ijfDzSM+tUJF6na/SB7izFmtxQsIzRgcv893PTxEfzajTd0OEd/X76Wge6uVrieyodYx
         4MrX2IgHKAakArMrtpmnrBqPfYQNkGhjkSGqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698832708; x=1699437508;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3pfk9cqqe8i+/+fOTb1lE6xWp6G+mo2TybLpvLQN5I=;
        b=jNE6vMuYfuR6w6T10gxsjRhkoWCayEOLeILIlfL4wSLrg4Xo7xoVTWavymXdG8LtT5
         OTbZNZh2WQU88oHMA5iT0cAHXBewZdQ6mzA5TQK1zDVZI7ic0URC/pn+gQOkLIrSjC+B
         p6DMFPHMG9o3QKoKEGZedShkTUdC2s1d4xmxZ4SPNrb+xgyL1I1SHNEYg7AvIcK/VWKO
         R+BwOrdopAIElaeDtG55HYkAXMHoZqMPqrb7M86exsUg4eEGn/oiVuhtsD5W0fVG4Msa
         asFzUE0iTSPp+EnF0Dg2NHgk3TR6jO7raGtYP1Gjf/AKp6AidK0EZ7Vy+e7KROCh5n1d
         Vtzg==
X-Gm-Message-State: AOJu0Yxx92Xr2waVd46Wa1dCHhEgXm8MlQIVyMhST4uhFOT/Hn184N5H
        tHVyJzkKikiwwZQEaVEXe3mmmNFlz7GkwGfi1lnUgUrCvdETQAI/OjII5LrHP+vn0LsD2Ns6uho
        y8/sZ46lMfeHDtKKlLCbPmJzIsxwru9Ertw==
X-Google-Smtp-Source: AGHT+IGQktC2sEKth5oRBZPP6Z1EhwkaAU+R6GmqPxY+ksuSnwAzmNrgIMKI8l+p6kYO5vwANxomVoaDLf1ydNcZEPE=
X-Received: by 2002:a17:907:3fa0:b0:9bf:d65d:dc0f with SMTP id
 hr32-20020a1709073fa000b009bfd65ddc0fmr1668531ejc.4.1698832707889; Wed, 01
 Nov 2023 02:58:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:ee84:b0:9d1:3fc8:cea7 with HTTP; Wed, 1 Nov 2023
 02:58:27 -0700 (PDT)
Reply-To: mrslovethkonnia5@gmail.com
From:   PM <evitanadiadamayanti.2020@student.uny.ac.id>
Date:   Wed, 1 Nov 2023 09:58:27 +0000
Message-ID: <CAFhWKU2c-3mdiF2LU-ZkgQ8X+be2rXq662KOPvvfWK6yc=3eFg@mail.gmail.com>
Subject: Querido
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ol=C3=A1 querido,

Como voc=C3=AA est=C3=A1 hoje?

Te mandei um e-mail ontem, voc=C3=AA recebeu?

Sra.Loveth Konnia

....................................

Hello Dear,

How are you doing today?

I sent you an email yesterday, did you receive it?

Mrs.Loveth Konnia

--=20



-------------------------------------------Untuk mendukung =E2=80=9CGerakan=
 UNY=20
Hijau=E2=80=9D, disarankan tidak mencetak email ini dan lampirannya.
(To support=20
the =E2=80=9CGreen UNY movement=E2=80=9D, it is recommended not to print th=
e contents of=20
this email and its attachments)
Universitas Negeri Yogyakarta
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=20
www.uny.ac.id <http://www.uny.ac.id>
-------------------------------------------

