Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4D27809FB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359364AbjHRK0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376309AbjHRKZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:25:38 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9F935BC;
        Fri, 18 Aug 2023 03:25:33 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37IAP9bO058416;
        Fri, 18 Aug 2023 05:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692354309;
        bh=TXVCmEQVXofrWv6qdjUL2JKOGTiiel6dgGJBf5nH8JA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XTFYb/LB0ziNkfaqKLrIvcmZHWj87cy9KOyAu2cN3F4YWQxMcx19ifYlWSep0zDqg
         mYgYxXpvcI2Y0k224kqZ4NGTrWzLAVWfXgB3dhz62NoyFAD3Pa8GCsQOgk731gWp6e
         WrLaoB3LUwaX6KUNXq0HhsvVtkO/8vYABTJlqKW8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37IAP9F1026867
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Aug 2023 05:25:09 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 18
 Aug 2023 05:25:08 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 18 Aug 2023 05:25:08 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37IAP7eM007718;
        Fri, 18 Aug 2023 05:25:08 -0500
Date:   Fri, 18 Aug 2023 15:55:06 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <a-bhatia1@ti.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Julien Massot <julien.massot@collabora.com>
Subject: Re: [PATCH v9 13/13] media: ti: Add CSI2RX support for J721E
Message-ID: <wgkjek77bolf5wabki7uhm6cxjy5g5z2ncoc6urr7dv5y6wnaw@yfh7ccogxfea>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
 <20230811-upstream_csi-v9-13-8943f7a68a81@ti.com>
 <ad042065-33a2-d42e-ce2e-628464102fc3@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="opufskhdk7stelxl"
Content-Disposition: inline
In-Reply-To: <ad042065-33a2-d42e-ce2e-628464102fc3@ideasonboard.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--opufskhdk7stelxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tomi,

Thanks for the review.

On Aug 15, 2023 at 16:00:51 +0300, Tomi Valkeinen wrote:
> On 11/08/2023 13:47, Jai Luthra wrote:
> > From: Pratyush Yadav <p.yadav@ti.com>
> >=20

=2E..

> > +
> > +static void ti_csi2rx_drain_callback(void *param)
> > +{
> > +	struct completion *drain_complete =3D param;
> > +
> > +	complete(drain_complete);
> > +}
> > +
> > +/** Drain the stale data left at the PSI-L endpoint.
> > + *
> > + * This might happen if no buffers are queued in time but source is st=
ill
> > + * streaming. Or rarely it may happen while stopping the stream. To pr=
event
>=20
> I understand the first one, but when does this happen when stopping the
> stream?
>=20

When multi-stream support is enabled the module-level pixel reset for=20
cannot be done when stopping a single stream, in which case some=20
in-flight data is left at the PSI-L endpoint despite enforcing the=20
DMACNTX reset before. The same was true till v7 of this series as well,=20
due to the module-level pixel reset being done in the wrong order=20
(before stopping stream on the source).

Not sure if this will happen for single-stream usecases now (since v8)

I will fix this and other comments when I post subsequent patches for=20
multi-stream.

> > + * that stale data corrupting the subsequent transactions, it is requi=
red to
> > + * issue DMA requests to drain it out.
> > + */
> > +static int ti_csi2rx_drain_dma(struct ti_csi2rx_dev *csi)
> > +{
> > +	struct dma_async_tx_descriptor *desc;
> > +	struct completion drain_complete;
> > +	dma_cookie_t cookie;
> > +	int ret;
> > +
> > +	init_completion(&drain_complete);
> > +
> > +	desc =3D dmaengine_prep_slave_single(csi->dma.chan, csi->dma.drain.pa=
ddr,
> > +					   csi->dma.drain.len, DMA_DEV_TO_MEM,
> > +					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> > +	if (!desc) {
> > +		ret =3D -EIO;
> > +		goto out;
> > +	}
> > +
> > +	desc->callback =3D ti_csi2rx_drain_callback;
> > +	desc->callback_param =3D &drain_complete;
> > +
> > +	cookie =3D dmaengine_submit(desc);
> > +	ret =3D dma_submit_error(cookie);
> > +	if (ret)
> > +		goto out;
> > +
> > +	dma_async_issue_pending(csi->dma.chan);
> > +
> > +	if (!wait_for_completion_timeout(&drain_complete,
> > +					 msecs_to_jiffies(DRAIN_TIMEOUT_MS))) {
> > +		dmaengine_terminate_sync(csi->dma.chan);
> > +		ret =3D -ETIMEDOUT;
> > +		goto out;
> > +	}
> > +out:
> > +	return ret;
> > +}
> > +
> > +static void ti_csi2rx_dma_callback(void *param)
> > +{
> > +	struct ti_csi2rx_buffer *buf =3D param;
> > +	struct ti_csi2rx_dev *csi =3D buf->csi;
> > +	struct ti_csi2rx_dma *dma =3D &csi->dma;
> > +	unsigned long flags;
> > +
> > +	/*
> > +	 * TODO: Derive the sequence number from the CSI2RX frame number
> > +	 * hardware monitor registers.
> > +	 */
> > +	buf->vb.vb2_buf.timestamp =3D ktime_get_ns();
> > +	buf->vb.sequence =3D csi->sequence++;
> > +
> > +	spin_lock_irqsave(&dma->lock, flags);
> > +
> > +	WARN_ON(!list_is_first(&buf->list, &dma->submitted));
> > +	vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
> > +	list_del(&buf->list);
> > +
> > +	/* If there are more buffers to process then start their transfer. */
> > +	while (!list_empty(&dma->queue)) {
> > +		buf =3D list_entry(dma->queue.next, struct ti_csi2rx_buffer, list);
> > +
> > +		if (ti_csi2rx_start_dma(csi, buf)) {
> > +			dev_err(csi->dev, "Failed to queue the next buffer for DMA\n");
> > +			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
> > +		} else {
> > +			list_move_tail(&buf->list, &dma->submitted);
> > +		}
> > +	}
> > +
> > +	if (list_empty(&dma->submitted))
> > +		dma->state =3D TI_CSI2RX_DMA_IDLE;
> > +
> > +	spin_unlock_irqrestore(&dma->lock, flags);
> > +}
> > +
> > +static int ti_csi2rx_start_dma(struct ti_csi2rx_dev *csi,
> > +			       struct ti_csi2rx_buffer *buf)
> > +{
> > +	unsigned long addr;
> > +	struct dma_async_tx_descriptor *desc;
> > +	size_t len =3D csi->v_fmt.fmt.pix.sizeimage;
> > +	dma_cookie_t cookie;
> > +	int ret =3D 0;
> > +
> > +	addr =3D vb2_dma_contig_plane_dma_addr(&buf->vb.vb2_buf, 0);
> > +	desc =3D dmaengine_prep_slave_single(csi->dma.chan, addr, len,
> > +					   DMA_DEV_TO_MEM,
> > +					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> > +	if (!desc)
> > +		return -EIO;
> > +
> > +	desc->callback =3D ti_csi2rx_dma_callback;
> > +	desc->callback_param =3D buf;
> > +
> > +	cookie =3D dmaengine_submit(desc);
> > +	ret =3D dma_submit_error(cookie);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dma_async_issue_pending(csi->dma.chan);
> > +
> > +	return 0;
> > +}
> > +
> > +static void ti_csi2rx_cleanup_buffers(struct ti_csi2rx_dev *csi,
> > +				      enum vb2_buffer_state buf_state)
> > +{
> > +	struct ti_csi2rx_dma *dma =3D &csi->dma;
> > +	struct ti_csi2rx_buffer *buf, *tmp;
> > +	enum ti_csi2rx_dma_state state;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	spin_lock_irqsave(&dma->lock, flags);
> > +	state =3D csi->dma.state;
> > +	dma->state =3D TI_CSI2RX_DMA_STOPPED;
> > +	spin_unlock_irqrestore(&dma->lock, flags);
> > +
> > +	if (state !=3D TI_CSI2RX_DMA_STOPPED) {
> > +		/*
> > +		 * Normal DMA termination sometimes does not clean up pending
> > +		 * data on the endpoint.
>=20
> When is "sometimes"? It's good to be more exact.
>=20
> > +		 */
> > +		ret =3D ti_csi2rx_drain_dma(csi);
> > +		if (ret)
> > +			dev_dbg(csi->dev,
> > +				"Failed to drain DMA. Next frame might be bogus\n");
> > +	}
> > +	ret =3D dmaengine_terminate_sync(csi->dma.chan);
> > +	if (ret)
> > +		dev_err(csi->dev, "Failed to stop DMA: %d\n", ret);
> > +
> > +	dma_free_coherent(csi->dev, dma->drain.len,
> > +			  dma->drain.vaddr, dma->drain.paddr);
> > +	dma->drain.vaddr =3D NULL;
> > +
> > +	spin_lock_irqsave(&dma->lock, flags);
> > +	list_for_each_entry_safe(buf, tmp, &csi->dma.queue, list) {
> > +		list_del(&buf->list);
> > +		vb2_buffer_done(&buf->vb.vb2_buf, buf_state);
> > +	}
> > +	list_for_each_entry_safe(buf, tmp, &csi->dma.submitted, list) {
> > +		list_del(&buf->list);
> > +		vb2_buffer_done(&buf->vb.vb2_buf, buf_state);
> > +	}
> > +	spin_unlock_irqrestore(&dma->lock, flags);
> > +}
> > +
> > +static int ti_csi2rx_queue_setup(struct vb2_queue *q, unsigned int *nb=
uffers,
> > +				 unsigned int *nplanes, unsigned int sizes[],
> > +				 struct device *alloc_devs[])
> > +{
> > +	struct ti_csi2rx_dev *csi =3D vb2_get_drv_priv(q);
> > +	unsigned int size =3D csi->v_fmt.fmt.pix.sizeimage;
> > +
> > +	if (*nplanes) {
> > +		if (sizes[0] < size)
> > +			return -EINVAL;
> > +		size =3D sizes[0];
> > +	}
> > +
> > +	*nplanes =3D 1;
> > +	sizes[0] =3D size;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_csi2rx_buffer_prepare(struct vb2_buffer *vb)
> > +{
> > +	struct ti_csi2rx_dev *csi =3D vb2_get_drv_priv(vb->vb2_queue);
> > +	unsigned long size =3D csi->v_fmt.fmt.pix.sizeimage;
> > +
> > +	if (vb2_plane_size(vb, 0) < size) {
> > +		dev_err(csi->dev, "Data will not fit into plane\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	vb2_set_plane_payload(vb, 0, size);
> > +	return 0;
> > +}
> > +
> > +static void ti_csi2rx_buffer_queue(struct vb2_buffer *vb)
> > +{
> > +	struct ti_csi2rx_dev *csi =3D vb2_get_drv_priv(vb->vb2_queue);
> > +	struct ti_csi2rx_buffer *buf;
> > +	struct ti_csi2rx_dma *dma =3D &csi->dma;
> > +	bool restart_dma =3D false;
> > +	unsigned long flags =3D 0;
> > +	int ret;
> > +
> > +	buf =3D container_of(vb, struct ti_csi2rx_buffer, vb.vb2_buf);
> > +	buf->csi =3D csi;
> > +
> > +	spin_lock_irqsave(&dma->lock, flags);
> > +	/*
> > +	 * Usually the DMA callback takes care of queueing the pending buffer=
s.
> > +	 * But if DMA has stalled due to lack of buffers, restart it now.
> > +	 */
> > +	if (dma->state =3D=3D TI_CSI2RX_DMA_IDLE) {
> > +		/*
> > +		 * Do not restart DMA with the lock held because
> > +		 * ti_csi2rx_drain_dma() might block for completion.
> > +		 * There won't be a race on queueing DMA anyway since the
> > +		 * callback is not being fired.
> > +		 */
> > +		restart_dma =3D true;
> > +		dma->state =3D TI_CSI2RX_DMA_ACTIVE;
> > +	} else {
> > +		list_add_tail(&buf->list, &dma->queue);
> > +	}
> > +	spin_unlock_irqrestore(&dma->lock, flags);
> > +
> > +	if (restart_dma) {
> > +		/*
> > +		 * Once frames start dropping, some data gets stuck in the DMA
> > +		 * pipeline somewhere. So the first DMA transfer after frame
> > +		 * drops gives a partial frame. This is obviously not useful to
> > +		 * the application and will only confuse it. Issue a DMA
> > +		 * transaction to drain that up.
> > +		 */
> > +		ret =3D ti_csi2rx_drain_dma(csi);
> > +		if (ret)
> > +			dev_warn(csi->dev,
> > +				 "Failed to drain DMA. Next frame might be bogus\n");
> > +
> > +		ret =3D ti_csi2rx_start_dma(csi, buf);
> > +		if (ret) {
> > +			dev_err(csi->dev, "Failed to start DMA: %d\n", ret);
> > +			spin_lock_irqsave(&dma->lock, flags);
> > +			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
> > +			dma->state =3D TI_CSI2RX_DMA_IDLE;
> > +			spin_unlock_irqrestore(&dma->lock, flags);
> > +		} else {
> > +			spin_lock_irqsave(&dma->lock, flags);
> > +			list_add_tail(&buf->list, &dma->submitted);
> > +			spin_unlock_irqrestore(&dma->lock, flags);
> > +		}
> > +	}
> > +}
> > +
> > +static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned in=
t count)
> > +{
> > +	struct ti_csi2rx_dev *csi =3D vb2_get_drv_priv(vq);
> > +	struct ti_csi2rx_dma *dma =3D &csi->dma;
> > +	struct ti_csi2rx_buffer *buf;
> > +	unsigned long flags;
> > +	int ret =3D 0;
> > +
> > +	spin_lock_irqsave(&dma->lock, flags);
> > +	if (list_empty(&dma->queue))
> > +		ret =3D -EIO;
> > +	spin_unlock_irqrestore(&dma->lock, flags);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dma->drain.len =3D csi->v_fmt.fmt.pix.sizeimage;
> > +	dma->drain.vaddr =3D dma_alloc_coherent(csi->dev, dma->drain.len,
> > +					      &dma->drain.paddr, GFP_KERNEL);
> > +	if (!dma->drain.vaddr)
> > +		return -ENOMEM;
>=20
> This is still allocating a large buffer every time streaming is started (=
and
> with streams support, a separate buffer for each stream?).
>=20
> Did you check if the TI DMA can do writes to a constant address? That wou=
ld
> be the best option, as then the whole buffer allocation problem goes away.
>=20

I checked with Vignesh, the hardware can support a scenario where we=20
flush out all the data without allocating a buffer, but I couldn't find=20
a way to signal that via the current dmaengine framework APIs. Will look=20
into it further as it will be important for multi-stream support.

> Alternatively, can you flush the buffers with multiple one line transfers?
> The flushing shouldn't be performance critical, so even if that's slower
> than a normal full-frame DMA, it shouldn't matter much. And if that can be
> done, a single probe time line-buffer allocation should do the trick.

There will be considerable overhead if we queue many DMA transactions=20
(in the order of 1000s or even 100s), which might not be okay for the=20
scenarios where we have to drain mid-stream. Will have to run some=20
experiments to see if that is worth it.

But one optimization we can for sure do is re-use a single drain buffer=20
for all the streams. We will need to ensure to re-allocate the buffer=20
for the "largest" framesize supported across the different streams at=20
stream-on time.

My guess is the endpoint is not buffering a full-frame's worth of data,=20
I will also check if we can upper bound that size to something feasible.

>=20
> Other than this drain buffer topic, I think this looks fine. So, I'm going
> to give Rb, but I do encourage you to look more into optimizing this drain
> buffer.

Thank you!

>=20
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>=20
>  Tomi
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--opufskhdk7stelxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmTfRv4ACgkQQ96R+SSa
cUXF+hAAum/nC+gIehaZVkNrQ6xC9ADg2Ay55PMvGvyfFMLKbH47lVJgBmSJI3V4
YN68an9huGRrCho2Q9jhVxeGSdTTHLnuxhCLPXdkvTkB7gLgd3xi3fXOQv1CHpEH
XANAlQzMLB8UGtUw8AqHRzgmV2ibpmnukaobkOecs0pk1BISKd3GgShyhYMkV/VQ
mIZQIssmbymuuyqEEoD9K9sPU5nN7mFBLP0ERCk86UE3+hqjCrHhM4tarDLzkdQj
me4jUR2AKymofwH/tr5IJwFl5BId97igbv+gaiPLT8EBKyowJy3f8uLXrQfBLZ8z
0FORnyLfn5OnlWhOt/FdIR0nMq7NFOKZOfNL164715pqdxOGkNANmzB3HpJ1vn7r
B5w+Lf7tL6oX78AMMR521MV+mHCYSnqspHWvzRNsAn3v+oh+A7orHf99eIOJ6q7S
OaAKILaZPBrVnS3q9atXCOkMCcgEOvx4cDCWeOpTxxmzG5ZSv//Pu3u8ssdgxh9v
TWJtpQWWCpUF0P3PBhIrXl7zhfhvzFHw58dwBuMhvEoNfdEHeEcTQRKcZi4Wun3y
aclpH6LNxkoViS8lw0fwLZNpYI5Q1r0w+qteINPB54G4CY8vk9hbtSmuRATDZVQw
3Hl35jwd0MRX/mdMIloU46kUPE8Tc7OFokOvF4p80wf+U+uOMKw=
=oso0
-----END PGP SIGNATURE-----

--opufskhdk7stelxl--
