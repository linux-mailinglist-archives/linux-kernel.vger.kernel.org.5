Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ED97E7F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjKJRyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjKJRxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:53:07 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAF22A27F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1699613320; x=1699872520;
        bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ZxkPzHWLIhK5UyeV1jeoueAYEj83QUfni2dYgKzMVxl/+rx5139gCAEVjlsAX4vLo
         1rNSuWW/A+snyoddCXON+NUiDq9uK2ANNLLg7XDfQru69eBZNNjLbhWvE/GQ75qPv5
         XpeV3kEbQlj+iNMob/5C9RbQ1TNTAk3Og/u9A5UXSuLdTADw8pi1UbTISSP3cT9aGQ
         n6fiMEcGKUjQkyhAZQcPl0h9v8cE3DssfIcg3hb14clklIiK02nNBt+vaMc+29GgS8
         7MNpcUP4x0sC+hVA+3Q7SXqt+znX/CZcbnX5f7WQ9F748+JiQTSfIgF+/QLLhrrOQQ
         0qXwM3rBJuvWQ==
Date:   Fri, 10 Nov 2023 10:48:24 +0000
To:     Javier Martinez Canillas <javierm@redhat.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     linux-kernel@vger.kernel.org, Sima Vetter <daniel.vetter@ffwll.ch>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Erico Nunes <nunes.erico@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 5/6] drm/plane: Extend damage tracking kernel-doc
Message-ID: <qdMlBGv4FDrkh7ReBUjr0bIxtX7XsICq9YWIMn3tCE2ThkUCKzOr13_KTvWjCYniBGffjq4wXtTkGwc_mFVWDykIFKvsNO6Y7aXUdyNdcIY=@emersion.fr>
In-Reply-To: <20231109172449.1599262-6-javierm@redhat.com>
References: <20231109172449.1599262-1-javierm@redhat.com> <20231109172449.1599262-6-javierm@redhat.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Simon Ser <contact@emersion.fr>
