Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6026A7ADB1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjIYPOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjIYPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:14:36 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A44110C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:14:29 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id a1e0cc1a2514c-79df12ff0f0so2115116241.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=happybizdata-com.20230601.gappssmtp.com; s=20230601; t=1695654868; x=1696259668; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BtNfrxgf4X+cTsDMONzKl75qRElkb7tAwQe0Ph+Ar2Q=;
        b=j4+1lOKQ75Eteyh3mYqAyulI5GJlyRFQpsBL2yBKWMLLGcf7Nb/I7hdZsguNApdfDt
         rqeZSBiexuk1yh83iBi+uNIsWm0MZ763QD5dQgOMttnfNsxdbVv++xlQyitQXpdiN/p7
         Dc5yozavczGK0Gl0GkFK1iFKMzXCKLqzINCixYXmCdv8R6fdILdfGcoNCxJpIzhDpo2Z
         AUtBUsgjzCu11bNqil8hpXgEFGmSYx56yz5mRltmJBAMvpe8DZZWaLy/2AXEepBtZ24S
         71KB4AI3pTR6oZZ3r7tiNd/ODzvNAzaaHF4yZbPbjNVUH9WwrQC8VMcDsGBzEabFZsAw
         zmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695654868; x=1696259668;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BtNfrxgf4X+cTsDMONzKl75qRElkb7tAwQe0Ph+Ar2Q=;
        b=G7+BtHFseZ6AE5PCrJOF80/UEJCAwtFM5SYBY15EUnxslI04FGbRfw/+uc1Z0mAJ+D
         6pz1FtZhvFUpA6g/Q11gtSz4vibkKFw9F2DvhUNmb4O75nGdn1i5HRdA2T2Z6oz/FlHo
         lqnG8rpWAEjJivqY4o4AiEGNbKSlFuhD6WSuxO94/p2FE+sg3gzIRgLL0plIyLGya+R4
         yVFgb7yRih+796d8PyISmyP33AnMENTA3Im7TKSZRB8cYqQQLOivaua4TXDzU1BPMusd
         uCMbbBWUVapOZWEPMhNWBOcn1H+LLdd3nMfVbS95EUuPavdtMI0+FFXi2Kcl/BWZY8EL
         AyRA==
X-Gm-Message-State: AOJu0Ywh19U6KEZFG60qi4GxesykLAI6Qd9defrrCLzh5TjiKn5t0PLB
        dnjudqoYPLwAsITjJkCdy83kNn5pJeYW+AbK6vT8dBpsm+z1/xeASmouzuqw
X-Google-Smtp-Source: AGHT+IExQPiZeST6UBNLhESqww9YHARUad58911NAde7hcBWx2F6ERBPJHqYcyUSazR13vV6oN3kFh0eB9Fgb/bu72c=
X-Received: by 2002:a67:f842:0:b0:452:5c6d:78c9 with SMTP id
 b2-20020a67f842000000b004525c6d78c9mr4218569vsp.12.1695654868281; Mon, 25 Sep
 2023 08:14:28 -0700 (PDT)
MIME-Version: 1.0
From:   Sofia Gonzales <sofia@happybizdata.com>
Date:   Mon, 25 Sep 2023 10:14:15 -0500
Message-ID: <CAMh3ZMJ_yEt0YCimcbJ+BwwJSX+PGktO6dGS1gmSQ1snAUqVpg@mail.gmail.com>
Subject: RE: HIMSS Global Health Conference Email List 2023
To:     Sofia Gonzales <sofia@happybizdata.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you be interested in acquiring the Healthcare Information and
Management Systems Society Email List?

Number of Contacts: 45,486
Cost: $1,918

Interested? Email me back; I would love to provide more information on the list.

Kind Regards,
Sofia Gonzales
Marketing Coordinator
