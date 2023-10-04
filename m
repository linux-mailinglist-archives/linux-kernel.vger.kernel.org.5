Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D517B8DAB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbjJDTv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjJDTv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:51:57 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B2FAB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1696449110; x=1696708310;
        bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=FxeYw43ciG3G8/382Bo3V+n+BsEkzxdsBPcA7pcZGL/oxq7EdaDECnlSnsAX5Sacw
         y3zL/mst+9WA4ewD0KTL7dF/dynX9qwUdiWkGjaaMjzK6YEyq7GCmhBw/QZpR1P4Yk
         iK0De/PYZ2YoheHeSuE8RXYaFcFVo+GFKO69oxcScBdIKE6N7dIuhbS39qPTRNm0J3
         K65MCHwuzyJM6LpDZmi76y4Rb/6wcgggr5zFc2vUnuJyboI4tXuzE3y5TctqtqAwy2
         rrxpkWOlf32ez5IVPaHDY3arWFByse/hOfNmwrJMh6Fn7qdf30NWs+BklCOZtl7Z93
         gx3Lwr7QQ7lMA==
Date:   Wed, 04 Oct 2023 19:51:37 +0000
To:     Randy Dunlap <rdunlap@infradead.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/3] drm/rect: fix kernel-doc typos
Message-ID: <dN-9E2Dosnsb4zlBmBomlMgGIP3qfO7jBoF0lvWqB_waBdrOCsqIzgj1YC5oxfQyj7LfP4tXfJJRzDWy5UfL4RPXRO5-jtUozHAgH_nCpdU=@emersion.fr>
In-Reply-To: <20231003011349.27593-3-rdunlap@infradead.org>
References: <20231003011349.27593-1-rdunlap@infradead.org> <20231003011349.27593-3-rdunlap@infradead.org>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Simon Ser <contact@emersion.fr>
