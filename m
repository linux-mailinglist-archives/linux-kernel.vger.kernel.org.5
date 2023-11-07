Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7329A7E4708
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbjKGRbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjKGRbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:31:51 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB74DC0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:31:48 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4083f61312eso45007705e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 09:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699378307; x=1699983107; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irPAQfW+mvtwNaPYPUDXBbA+Wq2jprV9I059/BD9mPU=;
        b=WC9YfL7yIoBChxomp8nT33rfE+wVD3oUKkMIHv9YUCjWEMEmF6PRISOJTWPM6/6F8S
         RKfBArqRB2+tEAhb3KGNJomoDlLasLpeOAQhHAj9WNAkurCulhTa9lUNKp2DM9brSuNT
         HTFm7ENgr5/5684rHNWO1U6u0MCpAWNmH3FcDfNgMXR4dYHHGXx4Dq6TphTboe6a8JuQ
         NQKK64YmBiFsicKXlmTIy0SCLgXtylWCjGOqY3nXgQOkJ1T86zLuz8MOj7JJC9KTRDZB
         nxs0pfVPZ6Dzw/3Jz5QATDNiJROLxi2PTivrMYwA9I/loXgzy4DpGmyDEmXcFLgIFNcw
         hiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699378307; x=1699983107;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irPAQfW+mvtwNaPYPUDXBbA+Wq2jprV9I059/BD9mPU=;
        b=Tcr3/kGOn0gT4c7az7sDcUqsLqSoVUHz9zvftZmplqJpdwGu67lw1WSLn0LXRXcWYx
         bvil6hWABQDnrt8gZ7QgXYQgBqSWvF0GNzEI8vGD7jKzzZMUFEtkCO1CoDMo0hH86tA2
         aTB4wV4FRtLbOJOVxdpi5stUcamUoOuGOatwUOdt4gjaXq7D4kSHpsMXoFEUoe5Ykthc
         cQICiLtVH79oyDRj9tokCZhWBdW0FKk4Tq6j3bZwQ4evf1VA3VgCoW+2DL978DkHGOcg
         hIUdkBPDdKS7mRwpK+Hbf9TBnzQ4lUGlBZcoH/N5likghhOMVPJpKABVeYPwlSbnTHAV
         97yg==
X-Gm-Message-State: AOJu0YzIvroRshpfo3MdF5m0mpByEb1u2mtTwQNG46PMOrJfRymjV9H9
        VCAromLEfZYnC4yBNGoO4OTV6IA3z2magPIOafw=
X-Google-Smtp-Source: AGHT+IFk7UuBfg173ddoiinGDg2hs0IqNHQcWF3txbuzG8tA4aJ3fWW7oW570REQ9/oGVyYDsUJcZVHGq0M5yXnDnIo=
X-Received: by 2002:a5d:588f:0:b0:32f:7e4e:535d with SMTP id
 n15-20020a5d588f000000b0032f7e4e535dmr25945346wrf.15.1699378306603; Tue, 07
 Nov 2023 09:31:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:6204:0:b0:31c:5443:7197 with HTTP; Tue, 7 Nov 2023
 09:31:46 -0800 (PST)
Reply-To: david.harden.chantal29@gmail.com
From:   "david.harden.chantal29" <belingvanben@gmail.com>
Date:   Tue, 7 Nov 2023 17:31:46 +0000
Message-ID: <CAHCuceWpjVSA7=kNeTiBQpkcwb9CohXzO-g695BZfRqyQjqB9Q@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SANTANDER BANK COMPENSATION UNIT, IN AFFILIATION WITH THE UNITED
NATION: Your compensation fund of 5.2 million dollar. is ready for
payment. kindly contact me for more details.
thanks
