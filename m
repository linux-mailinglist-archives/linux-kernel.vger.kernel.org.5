Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D75478ECC9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244873AbjHaMKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjHaMKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:10:05 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C669C5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:10:03 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41215efeb1aso3960331cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693483802; x=1694088602; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouabIiVNvKi28i28B0eVYMr+RTwjweivAM5QTSetrEY=;
        b=al0gCUI36Z99tutgyD2nVzf6L+Coo/6sjrlyAYv9oVCJrxyL/ynEFpRDQCRNyTvYrA
         xVzG8mCzraJVTI8UvpQWiVWpyniN7kRxmHnZj1Wx6rJUpYlxoisRmQIq8BgVnGU1g6tG
         aCpkFc6+HBxPT7LD8e0EiMAKNE+THmtP22ndbtqAuQf/8zt2Fx9EYjqdJXpVjSL2G4Fe
         ZpKlm/e2a95tOeu4a6+qaDBw5dctm1Lh2JKxYeGIwvFmYSmKhuUVpS/gY2nf2K/a3DIO
         L0u+J15qcY2pAdwoEcSihx/6UH8GJ14ZmQELCUTWplcSrXz8pAcqzVNnnUGbU7z/nnZV
         9qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693483802; x=1694088602;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouabIiVNvKi28i28B0eVYMr+RTwjweivAM5QTSetrEY=;
        b=Q4FHOuO8nK2A20Bcf2mhjagIZfOaxzX16GPTS+KrP8bJJrJCEUkZ/QXTNib4QgNMPc
         Qmlhp1CCIhypQ9qko0rMUGV5G9ChrabaVsxNcpgGlSH4rp4aihLawZmao9c++r8Dbap4
         O0UShXV8RRQBB4oEria1op5t2HsDRyHnERo0GrAF9BbIo34CZ9O5hdgnXICq6jpU+Mly
         62jGC8BwqQ+vwq1XQoEuTIZ7efGhKC42vjVmLds3d1IfyYjavpkUyczzDW39dAE4Eupm
         CQ0jPPLsfBlJkCFJJMN6jrS4zuXgVlRLDEVRELBMIrcDZmsl2MsK9C5VwN8cpGehm/0W
         mftg==
X-Gm-Message-State: AOJu0YxpM7q3KmlnkkO7xPFMdbGzV/KuGckOy5KK2xxMwTeusUDGFL3Y
        6Zt5RtI8Re2PlVDq8ockTliwkkVcfTY0U8XB/wg=
X-Google-Smtp-Source: AGHT+IHO/gplT1arVaympHaGnFaxClGlF9CGWiFgptLy0XcW58291mE4R8WVeg5kZr71m963sEJ8NeF+LoqU1NnwJMU=
X-Received: by 2002:ac8:4e47:0:b0:403:a940:dc88 with SMTP id
 e7-20020ac84e47000000b00403a940dc88mr2924689qtw.20.1693483802129; Thu, 31 Aug
 2023 05:10:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7cae:0:b0:40c:facc:de43 with HTTP; Thu, 31 Aug 2023
 05:10:01 -0700 (PDT)
Reply-To: avocatss.cl@gmail.com
From:   "A. Kossi Esq" <roroseline7@gmail.com>
Date:   Thu, 31 Aug 2023 12:10:01 +0000
Message-ID: <CAMTv+KJ8CtmMUNH2tCa6k02GQ0jb4rrVU-MRCdJska7bv_hrWg@mail.gmail.com>
Subject: Res
To:     kossi <kossi@inbox.lv>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello dear,

I hope you are well, did you receive the details of the transaction I
sent to you last week ? Kindly confirm and get back to me .


Kind regards,
A. Kossi esq.
